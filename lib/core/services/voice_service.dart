import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class ModernVoiceService {
  final String _projectId;
  final String _credentialsPath;
  AutoRefreshingAuthClient? _authClient;

  // Instancia del nuevo paquete de Speech-to-Text
  final SpeechToText _speechToText = SpeechToText();
  bool _isSpeechInitialized = false;

  ModernVoiceService({
    required String projectId,
    required String credentialsPath,
  })  : _projectId = projectId,
        _credentialsPath = credentialsPath;

  /// Inicializa tanto el cliente de autenticación como el servicio de voz.
  Future<bool> initialize() async {
    // Inicializa la autenticación para la API de Dialogflow
    try {
      final jsonString = await rootBundle.loadString(_credentialsPath);
      final credentials = ServiceAccountCredentials.fromJson(jsonString);
      final scopes = ['https://www.googleapis.com/auth/cloud-platform'];
      _authClient = await clientViaServiceAccount(credentials, scopes);
    } catch (e) {
      print("Error inicializando autenticación: $e");
      return false;
    }

    // Inicializa el servicio de Speech-to-Text
    if (!_isSpeechInitialized) {
      _isSpeechInitialized = await _speechToText.initialize(
        onError: (error) => print("Error en STT: $error"),
        onStatus: (status) => print("Estado de STT: $status"),
      );
    }
    return _authClient != null && _isSpeechInitialized;
  }

  /// Escucha al usuario y, cuando obtiene un resultado, lo envía a Dialogflow.
  /// Devuelve el resultado final de Dialogflow.
  Future<Map<String, dynamic>?> listenAndDetectIntent({
    required String sessionId,
    required Function(String text) onSpeechResult, // Callback para mostrar texto en UI
  }) async {
    if (!_isSpeechInitialized || _authClient == null) {
      print("El servicio no está inicializado.");
      return null;
    }

    final completer = Completer<Map<String, dynamic>?>();

    _speechToText.listen(
      localeId: 'es_PE', // Puedes ajustar el dialecto
      onResult: (SpeechRecognitionResult result) async {
        // Actualiza la UI con el texto que se va reconociendo
        onSpeechResult(result.recognizedWords);

        // Cuando el reconocimiento es final (el usuario dejó de hablar)
        if (result.finalResult) {
          final transcript = result.recognizedWords;
          if (transcript.isNotEmpty) {
            // Llama a Dialogflow con el texto obtenido
            final dialogflowResult = await _detectIntent(transcript, sessionId);
            completer.complete(dialogflowResult);
          } else {
            completer.complete(null);
          }
        }
      },
    );

    return completer.future;
  }
  
  /// Detiene la escucha del micrófono.
  Future<void> stopListening() async {
    if (_speechToText.isListening) {
      await _speechToText.stop();
    }
  }

  /// Método privado que hace la llamada a la API REST de Dialogflow.
  Future<Map<String, dynamic>?> _detectIntent(String text, String sessionId) async {
    final url = Uri.parse('https://dialogflow.googleapis.com/v2/projects/$_projectId/agent/sessions/$sessionId:detectIntent');
    
    final body = {
      "queryInput": {
        "text": {"text": text, "languageCode": "es"}
      }
    };

    try {
      final response = await _authClient!.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['queryResult'];
      } else {
        print("Error en Dialogflow API: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Excepción al llamar a Dialogflow: $e");
      return null;
    }
  }
}