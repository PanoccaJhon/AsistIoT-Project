// M: Representa la estructura de datos y el estado de un dispositivo.
class LightDevice {
  final String id;
  final String name;
  final bool isOn;
  final bool isAutoMode;
  final bool? motionDetected;
  final int? lightLevel;
  
  // --- CAMPOS NUEVOS ---
  /// Indica si el dispositivo está actualmente conectado a AWS IoT.
  final bool online;
  /// Timestamp (en milisegundos) de la última vez que el dispositivo reportó su estado.
  final int lastSeenTimestamp;

  LightDevice({
    required this.id,
    required this.name,
    this.isOn = false,
    this.isAutoMode = true,
    this.motionDetected,
    this.lightLevel,
    this.online = false,
    this.lastSeenTimestamp = 0,
  });

  /// Constructor de fábrica para crear una instancia de LightDevice desde un JSON.
  /// Se espera que el JSON sea el objeto 'reported' de la sombra del dispositivo.
  factory LightDevice.fromJson(String id, String name, Map<String, dynamic> json) {
    // Extraemos los sub-objetos de forma segura, proveyendo un mapa vacío si no existen.
    final lights = json['estado_luces'] as Map<String, dynamic>? ?? {};
    final sensors = json['sensores'] as Map<String, dynamic>? ?? {};
    final config = json['config'] as Map<String, dynamic>? ?? {};
    
    // El estado 'online' y el 'timestamp' usualmente vienen de la metadata de la sombra,
    // que tu Lambda tendría que añadir a la respuesta. Aquí usamos valores por defecto.
    final metadata = json['metadata'] as Map<String, dynamic>? ?? {};
    final reportedMeta = metadata['reported'] as Map<String, dynamic>? ?? {};

    return LightDevice(
      id: id,
      name: name,
      // Asumimos que 'luz1' es la luz principal.
      isOn: lights['luz1'] == 'ON', 
      isAutoMode: config['modo_auto'] ?? true,
      motionDetected: sensors['movimiento'],
      lightLevel: sensors['lux'],
      // Idealmente, tu Lambda también devolvería el estado de conexión.
      online: json['online'] ?? false, 
      lastSeenTimestamp: reportedMeta['timestamp'] as int? ?? 0,
    );
  }

  /// Crea una copia de la instancia actual con los valores actualizados.
  /// Muy útil para la gestión de estado en el ViewModel.
  LightDevice copyWith({
    String? id,
    String? name,
    bool? isOn,
    bool? isAutoMode,
    bool? motionDetected,
    int? lightLevel,
    bool? online,
    int? lastSeenTimestamp,
  }) {
    return LightDevice(
      id: id ?? this.id,
      name: name ?? this.name,
      isOn: isOn ?? this.isOn,
      isAutoMode: isAutoMode ?? this.isAutoMode,
      motionDetected: motionDetected ?? this.motionDetected,
      lightLevel: lightLevel ?? this.lightLevel,
      online: online ?? this.online,
      lastSeenTimestamp: lastSeenTimestamp ?? this.lastSeenTimestamp,
    );
  }

  @override
  String toString() {
    return 'LightDevice(id: $id, name: $name, isOn: $isOn, online: $online)';
  }
}