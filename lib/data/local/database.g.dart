// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DispositivosTable extends Dispositivos
    with TableInfo<$DispositivosTable, Dispositivo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DispositivosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dispositivos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Dispositivo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Dispositivo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Dispositivo(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      nombre:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}nombre'],
          )!,
    );
  }

  @override
  $DispositivosTable createAlias(String alias) {
    return $DispositivosTable(attachedDatabase, alias);
  }
}

class Dispositivo extends DataClass implements Insertable<Dispositivo> {
  final String id;
  final String nombre;
  const Dispositivo({required this.id, required this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    return map;
  }

  DispositivosCompanion toCompanion(bool nullToAbsent) {
    return DispositivosCompanion(id: Value(id), nombre: Value(nombre));
  }

  factory Dispositivo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dispositivo(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  Dispositivo copyWith({String? id, String? nombre}) =>
      Dispositivo(id: id ?? this.id, nombre: nombre ?? this.nombre);
  Dispositivo copyWithCompanion(DispositivosCompanion data) {
    return Dispositivo(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dispositivo(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dispositivo &&
          other.id == this.id &&
          other.nombre == this.nombre);
}

class DispositivosCompanion extends UpdateCompanion<Dispositivo> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<int> rowid;
  const DispositivosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DispositivosCompanion.insert({
    required String id,
    required String nombre,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nombre = Value(nombre);
  static Insertable<Dispositivo> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DispositivosCompanion copyWith({
    Value<String>? id,
    Value<String>? nombre,
    Value<int>? rowid,
  }) {
    return DispositivosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DispositivosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EstadosDispositivosTable extends EstadosDispositivos
    with TableInfo<$EstadosDispositivosTable, EstadoDispositivo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EstadosDispositivosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idDispositivoMeta = const VerificationMeta(
    'idDispositivo',
  );
  @override
  late final GeneratedColumn<String> idDispositivo = GeneratedColumn<String>(
    'id_dispositivo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dispositivos (id)',
    ),
  );
  static const VerificationMeta _luz1EncendidaMeta = const VerificationMeta(
    'luz1Encendida',
  );
  @override
  late final GeneratedColumn<bool> luz1Encendida = GeneratedColumn<bool>(
    'luz1_encendida',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("luz1_encendida" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _luz2EncendidaMeta = const VerificationMeta(
    'luz2Encendida',
  );
  @override
  late final GeneratedColumn<bool> luz2Encendida = GeneratedColumn<bool>(
    'luz2_encendida',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("luz2_encendida" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _luxMeta = const VerificationMeta('lux');
  @override
  late final GeneratedColumn<double> lux = GeneratedColumn<double>(
    'lux',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _movimientoMeta = const VerificationMeta(
    'movimiento',
  );
  @override
  late final GeneratedColumn<bool> movimiento = GeneratedColumn<bool>(
    'movimiento',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("movimiento" IN (0, 1))',
    ),
  );
  static const VerificationMeta _modoAutoMeta = const VerificationMeta(
    'modoAuto',
  );
  @override
  late final GeneratedColumn<bool> modoAuto = GeneratedColumn<bool>(
    'modo_auto',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("modo_auto" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _ultimaActualizacionMeta =
      const VerificationMeta('ultimaActualizacion');
  @override
  late final GeneratedColumn<DateTime> ultimaActualizacion =
      GeneratedColumn<DateTime>(
        'ultima_actualizacion',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    idDispositivo,
    luz1Encendida,
    luz2Encendida,
    lux,
    movimiento,
    modoAuto,
    ultimaActualizacion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'estados_dispositivos';
  @override
  VerificationContext validateIntegrity(
    Insertable<EstadoDispositivo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_dispositivo')) {
      context.handle(
        _idDispositivoMeta,
        idDispositivo.isAcceptableOrUnknown(
          data['id_dispositivo']!,
          _idDispositivoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idDispositivoMeta);
    }
    if (data.containsKey('luz1_encendida')) {
      context.handle(
        _luz1EncendidaMeta,
        luz1Encendida.isAcceptableOrUnknown(
          data['luz1_encendida']!,
          _luz1EncendidaMeta,
        ),
      );
    }
    if (data.containsKey('luz2_encendida')) {
      context.handle(
        _luz2EncendidaMeta,
        luz2Encendida.isAcceptableOrUnknown(
          data['luz2_encendida']!,
          _luz2EncendidaMeta,
        ),
      );
    }
    if (data.containsKey('lux')) {
      context.handle(
        _luxMeta,
        lux.isAcceptableOrUnknown(data['lux']!, _luxMeta),
      );
    }
    if (data.containsKey('movimiento')) {
      context.handle(
        _movimientoMeta,
        movimiento.isAcceptableOrUnknown(data['movimiento']!, _movimientoMeta),
      );
    }
    if (data.containsKey('modo_auto')) {
      context.handle(
        _modoAutoMeta,
        modoAuto.isAcceptableOrUnknown(data['modo_auto']!, _modoAutoMeta),
      );
    }
    if (data.containsKey('ultima_actualizacion')) {
      context.handle(
        _ultimaActualizacionMeta,
        ultimaActualizacion.isAcceptableOrUnknown(
          data['ultima_actualizacion']!,
          _ultimaActualizacionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ultimaActualizacionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idDispositivo};
  @override
  EstadoDispositivo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EstadoDispositivo(
      idDispositivo:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id_dispositivo'],
          )!,
      luz1Encendida:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}luz1_encendida'],
          )!,
      luz2Encendida:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}luz2_encendida'],
          )!,
      lux: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lux'],
      ),
      movimiento: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}movimiento'],
      ),
      modoAuto:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}modo_auto'],
          )!,
      ultimaActualizacion:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}ultima_actualizacion'],
          )!,
    );
  }

  @override
  $EstadosDispositivosTable createAlias(String alias) {
    return $EstadosDispositivosTable(attachedDatabase, alias);
  }
}

class EstadoDispositivo extends DataClass
    implements Insertable<EstadoDispositivo> {
  final String idDispositivo;
  final bool luz1Encendida;
  final bool luz2Encendida;
  final double? lux;
  final bool? movimiento;
  final bool modoAuto;
  final DateTime ultimaActualizacion;
  const EstadoDispositivo({
    required this.idDispositivo,
    required this.luz1Encendida,
    required this.luz2Encendida,
    this.lux,
    this.movimiento,
    required this.modoAuto,
    required this.ultimaActualizacion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_dispositivo'] = Variable<String>(idDispositivo);
    map['luz1_encendida'] = Variable<bool>(luz1Encendida);
    map['luz2_encendida'] = Variable<bool>(luz2Encendida);
    if (!nullToAbsent || lux != null) {
      map['lux'] = Variable<double>(lux);
    }
    if (!nullToAbsent || movimiento != null) {
      map['movimiento'] = Variable<bool>(movimiento);
    }
    map['modo_auto'] = Variable<bool>(modoAuto);
    map['ultima_actualizacion'] = Variable<DateTime>(ultimaActualizacion);
    return map;
  }

  EstadosDispositivosCompanion toCompanion(bool nullToAbsent) {
    return EstadosDispositivosCompanion(
      idDispositivo: Value(idDispositivo),
      luz1Encendida: Value(luz1Encendida),
      luz2Encendida: Value(luz2Encendida),
      lux: lux == null && nullToAbsent ? const Value.absent() : Value(lux),
      movimiento:
          movimiento == null && nullToAbsent
              ? const Value.absent()
              : Value(movimiento),
      modoAuto: Value(modoAuto),
      ultimaActualizacion: Value(ultimaActualizacion),
    );
  }

  factory EstadoDispositivo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EstadoDispositivo(
      idDispositivo: serializer.fromJson<String>(json['idDispositivo']),
      luz1Encendida: serializer.fromJson<bool>(json['luz1Encendida']),
      luz2Encendida: serializer.fromJson<bool>(json['luz2Encendida']),
      lux: serializer.fromJson<double?>(json['lux']),
      movimiento: serializer.fromJson<bool?>(json['movimiento']),
      modoAuto: serializer.fromJson<bool>(json['modoAuto']),
      ultimaActualizacion: serializer.fromJson<DateTime>(
        json['ultimaActualizacion'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idDispositivo': serializer.toJson<String>(idDispositivo),
      'luz1Encendida': serializer.toJson<bool>(luz1Encendida),
      'luz2Encendida': serializer.toJson<bool>(luz2Encendida),
      'lux': serializer.toJson<double?>(lux),
      'movimiento': serializer.toJson<bool?>(movimiento),
      'modoAuto': serializer.toJson<bool>(modoAuto),
      'ultimaActualizacion': serializer.toJson<DateTime>(ultimaActualizacion),
    };
  }

  EstadoDispositivo copyWith({
    String? idDispositivo,
    bool? luz1Encendida,
    bool? luz2Encendida,
    Value<double?> lux = const Value.absent(),
    Value<bool?> movimiento = const Value.absent(),
    bool? modoAuto,
    DateTime? ultimaActualizacion,
  }) => EstadoDispositivo(
    idDispositivo: idDispositivo ?? this.idDispositivo,
    luz1Encendida: luz1Encendida ?? this.luz1Encendida,
    luz2Encendida: luz2Encendida ?? this.luz2Encendida,
    lux: lux.present ? lux.value : this.lux,
    movimiento: movimiento.present ? movimiento.value : this.movimiento,
    modoAuto: modoAuto ?? this.modoAuto,
    ultimaActualizacion: ultimaActualizacion ?? this.ultimaActualizacion,
  );
  EstadoDispositivo copyWithCompanion(EstadosDispositivosCompanion data) {
    return EstadoDispositivo(
      idDispositivo:
          data.idDispositivo.present
              ? data.idDispositivo.value
              : this.idDispositivo,
      luz1Encendida:
          data.luz1Encendida.present
              ? data.luz1Encendida.value
              : this.luz1Encendida,
      luz2Encendida:
          data.luz2Encendida.present
              ? data.luz2Encendida.value
              : this.luz2Encendida,
      lux: data.lux.present ? data.lux.value : this.lux,
      movimiento:
          data.movimiento.present ? data.movimiento.value : this.movimiento,
      modoAuto: data.modoAuto.present ? data.modoAuto.value : this.modoAuto,
      ultimaActualizacion:
          data.ultimaActualizacion.present
              ? data.ultimaActualizacion.value
              : this.ultimaActualizacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EstadoDispositivo(')
          ..write('idDispositivo: $idDispositivo, ')
          ..write('luz1Encendida: $luz1Encendida, ')
          ..write('luz2Encendida: $luz2Encendida, ')
          ..write('lux: $lux, ')
          ..write('movimiento: $movimiento, ')
          ..write('modoAuto: $modoAuto, ')
          ..write('ultimaActualizacion: $ultimaActualizacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idDispositivo,
    luz1Encendida,
    luz2Encendida,
    lux,
    movimiento,
    modoAuto,
    ultimaActualizacion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EstadoDispositivo &&
          other.idDispositivo == this.idDispositivo &&
          other.luz1Encendida == this.luz1Encendida &&
          other.luz2Encendida == this.luz2Encendida &&
          other.lux == this.lux &&
          other.movimiento == this.movimiento &&
          other.modoAuto == this.modoAuto &&
          other.ultimaActualizacion == this.ultimaActualizacion);
}

class EstadosDispositivosCompanion extends UpdateCompanion<EstadoDispositivo> {
  final Value<String> idDispositivo;
  final Value<bool> luz1Encendida;
  final Value<bool> luz2Encendida;
  final Value<double?> lux;
  final Value<bool?> movimiento;
  final Value<bool> modoAuto;
  final Value<DateTime> ultimaActualizacion;
  final Value<int> rowid;
  const EstadosDispositivosCompanion({
    this.idDispositivo = const Value.absent(),
    this.luz1Encendida = const Value.absent(),
    this.luz2Encendida = const Value.absent(),
    this.lux = const Value.absent(),
    this.movimiento = const Value.absent(),
    this.modoAuto = const Value.absent(),
    this.ultimaActualizacion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EstadosDispositivosCompanion.insert({
    required String idDispositivo,
    this.luz1Encendida = const Value.absent(),
    this.luz2Encendida = const Value.absent(),
    this.lux = const Value.absent(),
    this.movimiento = const Value.absent(),
    this.modoAuto = const Value.absent(),
    required DateTime ultimaActualizacion,
    this.rowid = const Value.absent(),
  }) : idDispositivo = Value(idDispositivo),
       ultimaActualizacion = Value(ultimaActualizacion);
  static Insertable<EstadoDispositivo> custom({
    Expression<String>? idDispositivo,
    Expression<bool>? luz1Encendida,
    Expression<bool>? luz2Encendida,
    Expression<double>? lux,
    Expression<bool>? movimiento,
    Expression<bool>? modoAuto,
    Expression<DateTime>? ultimaActualizacion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idDispositivo != null) 'id_dispositivo': idDispositivo,
      if (luz1Encendida != null) 'luz1_encendida': luz1Encendida,
      if (luz2Encendida != null) 'luz2_encendida': luz2Encendida,
      if (lux != null) 'lux': lux,
      if (movimiento != null) 'movimiento': movimiento,
      if (modoAuto != null) 'modo_auto': modoAuto,
      if (ultimaActualizacion != null)
        'ultima_actualizacion': ultimaActualizacion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EstadosDispositivosCompanion copyWith({
    Value<String>? idDispositivo,
    Value<bool>? luz1Encendida,
    Value<bool>? luz2Encendida,
    Value<double?>? lux,
    Value<bool?>? movimiento,
    Value<bool>? modoAuto,
    Value<DateTime>? ultimaActualizacion,
    Value<int>? rowid,
  }) {
    return EstadosDispositivosCompanion(
      idDispositivo: idDispositivo ?? this.idDispositivo,
      luz1Encendida: luz1Encendida ?? this.luz1Encendida,
      luz2Encendida: luz2Encendida ?? this.luz2Encendida,
      lux: lux ?? this.lux,
      movimiento: movimiento ?? this.movimiento,
      modoAuto: modoAuto ?? this.modoAuto,
      ultimaActualizacion: ultimaActualizacion ?? this.ultimaActualizacion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idDispositivo.present) {
      map['id_dispositivo'] = Variable<String>(idDispositivo.value);
    }
    if (luz1Encendida.present) {
      map['luz1_encendida'] = Variable<bool>(luz1Encendida.value);
    }
    if (luz2Encendida.present) {
      map['luz2_encendida'] = Variable<bool>(luz2Encendida.value);
    }
    if (lux.present) {
      map['lux'] = Variable<double>(lux.value);
    }
    if (movimiento.present) {
      map['movimiento'] = Variable<bool>(movimiento.value);
    }
    if (modoAuto.present) {
      map['modo_auto'] = Variable<bool>(modoAuto.value);
    }
    if (ultimaActualizacion.present) {
      map['ultima_actualizacion'] = Variable<DateTime>(
        ultimaActualizacion.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EstadosDispositivosCompanion(')
          ..write('idDispositivo: $idDispositivo, ')
          ..write('luz1Encendida: $luz1Encendida, ')
          ..write('luz2Encendida: $luz2Encendida, ')
          ..write('lux: $lux, ')
          ..write('movimiento: $movimiento, ')
          ..write('modoAuto: $modoAuto, ')
          ..write('ultimaActualizacion: $ultimaActualizacion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DispositivosTable dispositivos = $DispositivosTable(this);
  late final $EstadosDispositivosTable estadosDispositivos =
      $EstadosDispositivosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dispositivos,
    estadosDispositivos,
  ];
}

typedef $$DispositivosTableCreateCompanionBuilder =
    DispositivosCompanion Function({
      required String id,
      required String nombre,
      Value<int> rowid,
    });
typedef $$DispositivosTableUpdateCompanionBuilder =
    DispositivosCompanion Function({
      Value<String> id,
      Value<String> nombre,
      Value<int> rowid,
    });

final class $$DispositivosTableReferences
    extends BaseReferences<_$AppDatabase, $DispositivosTable, Dispositivo> {
  $$DispositivosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EstadosDispositivosTable, List<EstadoDispositivo>>
  _estadosDispositivosRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.estadosDispositivos,
        aliasName: $_aliasNameGenerator(
          db.dispositivos.id,
          db.estadosDispositivos.idDispositivo,
        ),
      );

  $$EstadosDispositivosTableProcessedTableManager get estadosDispositivosRefs {
    final manager = $$EstadosDispositivosTableTableManager(
      $_db,
      $_db.estadosDispositivos,
    ).filter((f) => f.idDispositivo.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _estadosDispositivosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DispositivosTableFilterComposer
    extends Composer<_$AppDatabase, $DispositivosTable> {
  $$DispositivosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> estadosDispositivosRefs(
    Expression<bool> Function($$EstadosDispositivosTableFilterComposer f) f,
  ) {
    final $$EstadosDispositivosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.estadosDispositivos,
      getReferencedColumn: (t) => t.idDispositivo,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EstadosDispositivosTableFilterComposer(
            $db: $db,
            $table: $db.estadosDispositivos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DispositivosTableOrderingComposer
    extends Composer<_$AppDatabase, $DispositivosTable> {
  $$DispositivosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DispositivosTableAnnotationComposer
    extends Composer<_$AppDatabase, $DispositivosTable> {
  $$DispositivosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  Expression<T> estadosDispositivosRefs<T extends Object>(
    Expression<T> Function($$EstadosDispositivosTableAnnotationComposer a) f,
  ) {
    final $$EstadosDispositivosTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.estadosDispositivos,
          getReferencedColumn: (t) => t.idDispositivo,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EstadosDispositivosTableAnnotationComposer(
                $db: $db,
                $table: $db.estadosDispositivos,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DispositivosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DispositivosTable,
          Dispositivo,
          $$DispositivosTableFilterComposer,
          $$DispositivosTableOrderingComposer,
          $$DispositivosTableAnnotationComposer,
          $$DispositivosTableCreateCompanionBuilder,
          $$DispositivosTableUpdateCompanionBuilder,
          (Dispositivo, $$DispositivosTableReferences),
          Dispositivo,
          PrefetchHooks Function({bool estadosDispositivosRefs})
        > {
  $$DispositivosTableTableManager(_$AppDatabase db, $DispositivosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DispositivosTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DispositivosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$DispositivosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DispositivosCompanion(id: id, nombre: nombre, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required String nombre,
                Value<int> rowid = const Value.absent(),
              }) => DispositivosCompanion.insert(
                id: id,
                nombre: nombre,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DispositivosTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({estadosDispositivosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (estadosDispositivosRefs) db.estadosDispositivos,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (estadosDispositivosRefs)
                    await $_getPrefetchedData<
                      Dispositivo,
                      $DispositivosTable,
                      EstadoDispositivo
                    >(
                      currentTable: table,
                      referencedTable: $$DispositivosTableReferences
                          ._estadosDispositivosRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DispositivosTableReferences(
                                db,
                                table,
                                p0,
                              ).estadosDispositivosRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.idDispositivo == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DispositivosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DispositivosTable,
      Dispositivo,
      $$DispositivosTableFilterComposer,
      $$DispositivosTableOrderingComposer,
      $$DispositivosTableAnnotationComposer,
      $$DispositivosTableCreateCompanionBuilder,
      $$DispositivosTableUpdateCompanionBuilder,
      (Dispositivo, $$DispositivosTableReferences),
      Dispositivo,
      PrefetchHooks Function({bool estadosDispositivosRefs})
    >;
typedef $$EstadosDispositivosTableCreateCompanionBuilder =
    EstadosDispositivosCompanion Function({
      required String idDispositivo,
      Value<bool> luz1Encendida,
      Value<bool> luz2Encendida,
      Value<double?> lux,
      Value<bool?> movimiento,
      Value<bool> modoAuto,
      required DateTime ultimaActualizacion,
      Value<int> rowid,
    });
typedef $$EstadosDispositivosTableUpdateCompanionBuilder =
    EstadosDispositivosCompanion Function({
      Value<String> idDispositivo,
      Value<bool> luz1Encendida,
      Value<bool> luz2Encendida,
      Value<double?> lux,
      Value<bool?> movimiento,
      Value<bool> modoAuto,
      Value<DateTime> ultimaActualizacion,
      Value<int> rowid,
    });

final class $$EstadosDispositivosTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EstadosDispositivosTable,
          EstadoDispositivo
        > {
  $$EstadosDispositivosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DispositivosTable _idDispositivoTable(_$AppDatabase db) =>
      db.dispositivos.createAlias(
        $_aliasNameGenerator(
          db.estadosDispositivos.idDispositivo,
          db.dispositivos.id,
        ),
      );

  $$DispositivosTableProcessedTableManager get idDispositivo {
    final $_column = $_itemColumn<String>('id_dispositivo')!;

    final manager = $$DispositivosTableTableManager(
      $_db,
      $_db.dispositivos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idDispositivoTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EstadosDispositivosTableFilterComposer
    extends Composer<_$AppDatabase, $EstadosDispositivosTable> {
  $$EstadosDispositivosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get luz1Encendida => $composableBuilder(
    column: $table.luz1Encendida,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get luz2Encendida => $composableBuilder(
    column: $table.luz2Encendida,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lux => $composableBuilder(
    column: $table.lux,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get movimiento => $composableBuilder(
    column: $table.movimiento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get modoAuto => $composableBuilder(
    column: $table.modoAuto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ultimaActualizacion => $composableBuilder(
    column: $table.ultimaActualizacion,
    builder: (column) => ColumnFilters(column),
  );

  $$DispositivosTableFilterComposer get idDispositivo {
    final $$DispositivosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idDispositivo,
      referencedTable: $db.dispositivos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DispositivosTableFilterComposer(
            $db: $db,
            $table: $db.dispositivos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EstadosDispositivosTableOrderingComposer
    extends Composer<_$AppDatabase, $EstadosDispositivosTable> {
  $$EstadosDispositivosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get luz1Encendida => $composableBuilder(
    column: $table.luz1Encendida,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get luz2Encendida => $composableBuilder(
    column: $table.luz2Encendida,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lux => $composableBuilder(
    column: $table.lux,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get movimiento => $composableBuilder(
    column: $table.movimiento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get modoAuto => $composableBuilder(
    column: $table.modoAuto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ultimaActualizacion => $composableBuilder(
    column: $table.ultimaActualizacion,
    builder: (column) => ColumnOrderings(column),
  );

  $$DispositivosTableOrderingComposer get idDispositivo {
    final $$DispositivosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idDispositivo,
      referencedTable: $db.dispositivos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DispositivosTableOrderingComposer(
            $db: $db,
            $table: $db.dispositivos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EstadosDispositivosTableAnnotationComposer
    extends Composer<_$AppDatabase, $EstadosDispositivosTable> {
  $$EstadosDispositivosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get luz1Encendida => $composableBuilder(
    column: $table.luz1Encendida,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get luz2Encendida => $composableBuilder(
    column: $table.luz2Encendida,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lux =>
      $composableBuilder(column: $table.lux, builder: (column) => column);

  GeneratedColumn<bool> get movimiento => $composableBuilder(
    column: $table.movimiento,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get modoAuto =>
      $composableBuilder(column: $table.modoAuto, builder: (column) => column);

  GeneratedColumn<DateTime> get ultimaActualizacion => $composableBuilder(
    column: $table.ultimaActualizacion,
    builder: (column) => column,
  );

  $$DispositivosTableAnnotationComposer get idDispositivo {
    final $$DispositivosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idDispositivo,
      referencedTable: $db.dispositivos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DispositivosTableAnnotationComposer(
            $db: $db,
            $table: $db.dispositivos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EstadosDispositivosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EstadosDispositivosTable,
          EstadoDispositivo,
          $$EstadosDispositivosTableFilterComposer,
          $$EstadosDispositivosTableOrderingComposer,
          $$EstadosDispositivosTableAnnotationComposer,
          $$EstadosDispositivosTableCreateCompanionBuilder,
          $$EstadosDispositivosTableUpdateCompanionBuilder,
          (EstadoDispositivo, $$EstadosDispositivosTableReferences),
          EstadoDispositivo,
          PrefetchHooks Function({bool idDispositivo})
        > {
  $$EstadosDispositivosTableTableManager(
    _$AppDatabase db,
    $EstadosDispositivosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EstadosDispositivosTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$EstadosDispositivosTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$EstadosDispositivosTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> idDispositivo = const Value.absent(),
                Value<bool> luz1Encendida = const Value.absent(),
                Value<bool> luz2Encendida = const Value.absent(),
                Value<double?> lux = const Value.absent(),
                Value<bool?> movimiento = const Value.absent(),
                Value<bool> modoAuto = const Value.absent(),
                Value<DateTime> ultimaActualizacion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EstadosDispositivosCompanion(
                idDispositivo: idDispositivo,
                luz1Encendida: luz1Encendida,
                luz2Encendida: luz2Encendida,
                lux: lux,
                movimiento: movimiento,
                modoAuto: modoAuto,
                ultimaActualizacion: ultimaActualizacion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String idDispositivo,
                Value<bool> luz1Encendida = const Value.absent(),
                Value<bool> luz2Encendida = const Value.absent(),
                Value<double?> lux = const Value.absent(),
                Value<bool?> movimiento = const Value.absent(),
                Value<bool> modoAuto = const Value.absent(),
                required DateTime ultimaActualizacion,
                Value<int> rowid = const Value.absent(),
              }) => EstadosDispositivosCompanion.insert(
                idDispositivo: idDispositivo,
                luz1Encendida: luz1Encendida,
                luz2Encendida: luz2Encendida,
                lux: lux,
                movimiento: movimiento,
                modoAuto: modoAuto,
                ultimaActualizacion: ultimaActualizacion,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$EstadosDispositivosTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({idDispositivo = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (idDispositivo) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.idDispositivo,
                            referencedTable:
                                $$EstadosDispositivosTableReferences
                                    ._idDispositivoTable(db),
                            referencedColumn:
                                $$EstadosDispositivosTableReferences
                                    ._idDispositivoTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EstadosDispositivosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EstadosDispositivosTable,
      EstadoDispositivo,
      $$EstadosDispositivosTableFilterComposer,
      $$EstadosDispositivosTableOrderingComposer,
      $$EstadosDispositivosTableAnnotationComposer,
      $$EstadosDispositivosTableCreateCompanionBuilder,
      $$EstadosDispositivosTableUpdateCompanionBuilder,
      (EstadoDispositivo, $$EstadosDispositivosTableReferences),
      EstadoDispositivo,
      PrefetchHooks Function({bool idDispositivo})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DispositivosTableTableManager get dispositivos =>
      $$DispositivosTableTableManager(_db, _db.dispositivos);
  $$EstadosDispositivosTableTableManager get estadosDispositivos =>
      $$EstadosDispositivosTableTableManager(_db, _db.estadosDispositivos);
}
