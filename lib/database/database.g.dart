// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PetsTable extends Pets with TableInfo<$PetsTable, Pet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesMeta = const VerificationMeta(
    'species',
  );
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
    'species',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
    'breed',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthdateMeta = const VerificationMeta(
    'birthdate',
  );
  @override
  late final GeneratedColumn<int> birthdate = GeneratedColumn<int>(
    'birthdate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    species,
    breed,
    birthdate,
    photoPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('species')) {
      context.handle(
        _speciesMeta,
        species.isAcceptableOrUnknown(data['species']!, _speciesMeta),
      );
    }
    if (data.containsKey('breed')) {
      context.handle(
        _breedMeta,
        breed.isAcceptableOrUnknown(data['breed']!, _breedMeta),
      );
    }
    if (data.containsKey('birthdate')) {
      context.handle(
        _birthdateMeta,
        birthdate.isAcceptableOrUnknown(data['birthdate']!, _birthdateMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      species: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species'],
      ),
      breed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}breed'],
      ),
      birthdate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}birthdate'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
    );
  }

  @override
  $PetsTable createAlias(String alias) {
    return $PetsTable(attachedDatabase, alias);
  }
}

class Pet extends DataClass implements Insertable<Pet> {
  final int id;
  final String name;
  final String? species;
  final String? breed;
  final int? birthdate;
  final String? photoPath;
  const Pet({
    required this.id,
    required this.name,
    this.species,
    this.breed,
    this.birthdate,
    this.photoPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || species != null) {
      map['species'] = Variable<String>(species);
    }
    if (!nullToAbsent || breed != null) {
      map['breed'] = Variable<String>(breed);
    }
    if (!nullToAbsent || birthdate != null) {
      map['birthdate'] = Variable<int>(birthdate);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    return map;
  }

  PetsCompanion toCompanion(bool nullToAbsent) {
    return PetsCompanion(
      id: Value(id),
      name: Value(name),
      species: species == null && nullToAbsent
          ? const Value.absent()
          : Value(species),
      breed: breed == null && nullToAbsent
          ? const Value.absent()
          : Value(breed),
      birthdate: birthdate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthdate),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
    );
  }

  factory Pet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pet(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      species: serializer.fromJson<String?>(json['species']),
      breed: serializer.fromJson<String?>(json['breed']),
      birthdate: serializer.fromJson<int?>(json['birthdate']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'species': serializer.toJson<String?>(species),
      'breed': serializer.toJson<String?>(breed),
      'birthdate': serializer.toJson<int?>(birthdate),
      'photoPath': serializer.toJson<String?>(photoPath),
    };
  }

  Pet copyWith({
    int? id,
    String? name,
    Value<String?> species = const Value.absent(),
    Value<String?> breed = const Value.absent(),
    Value<int?> birthdate = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
  }) => Pet(
    id: id ?? this.id,
    name: name ?? this.name,
    species: species.present ? species.value : this.species,
    breed: breed.present ? breed.value : this.breed,
    birthdate: birthdate.present ? birthdate.value : this.birthdate,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
  );
  Pet copyWithCompanion(PetsCompanion data) {
    return Pet(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      species: data.species.present ? data.species.value : this.species,
      breed: data.breed.present ? data.breed.value : this.breed,
      birthdate: data.birthdate.present ? data.birthdate.value : this.birthdate,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pet(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('species: $species, ')
          ..write('breed: $breed, ')
          ..write('birthdate: $birthdate, ')
          ..write('photoPath: $photoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, species, breed, birthdate, photoPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pet &&
          other.id == this.id &&
          other.name == this.name &&
          other.species == this.species &&
          other.breed == this.breed &&
          other.birthdate == this.birthdate &&
          other.photoPath == this.photoPath);
}

class PetsCompanion extends UpdateCompanion<Pet> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> species;
  final Value<String?> breed;
  final Value<int?> birthdate;
  final Value<String?> photoPath;
  const PetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.species = const Value.absent(),
    this.breed = const Value.absent(),
    this.birthdate = const Value.absent(),
    this.photoPath = const Value.absent(),
  });
  PetsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.species = const Value.absent(),
    this.breed = const Value.absent(),
    this.birthdate = const Value.absent(),
    this.photoPath = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Pet> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? species,
    Expression<String>? breed,
    Expression<int>? birthdate,
    Expression<String>? photoPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (species != null) 'species': species,
      if (breed != null) 'breed': breed,
      if (birthdate != null) 'birthdate': birthdate,
      if (photoPath != null) 'photo_path': photoPath,
    });
  }

  PetsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? species,
    Value<String?>? breed,
    Value<int?>? birthdate,
    Value<String?>? photoPath,
  }) {
    return PetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      breed: breed ?? this.breed,
      birthdate: birthdate ?? this.birthdate,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (birthdate.present) {
      map['birthdate'] = Variable<int>(birthdate.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('species: $species, ')
          ..write('breed: $breed, ')
          ..write('birthdate: $birthdate, ')
          ..write('photoPath: $photoPath')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<int> petId = GeneratedColumn<int>(
    'pet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  systemComponents = GeneratedColumn<String>(
    'system_components',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<List<String>>($EventsTable.$convertersystemComponents);
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String>
  customBlueprintIds = GeneratedColumn<String>(
    'custom_blueprint_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<List<int>>($EventsTable.$convertercustomBlueprintIds);
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, int> timestamp =
      GeneratedColumn<int>(
        'timestamp',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<DateTime>($EventsTable.$convertertimestamp);
  static const VerificationMeta _loggedByNameMeta = const VerificationMeta(
    'loggedByName',
  );
  @override
  late final GeneratedColumn<String> loggedByName = GeneratedColumn<String>(
    'logged_by_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayLabelMeta = const VerificationMeta(
    'displayLabel',
  );
  @override
  late final GeneratedColumn<String> displayLabel = GeneratedColumn<String>(
    'display_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    petId,
    systemComponents,
    customBlueprintIds,
    timestamp,
    loggedByName,
    displayLabel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<Event> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_id')) {
      context.handle(
        _petIdMeta,
        petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta),
      );
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('logged_by_name')) {
      context.handle(
        _loggedByNameMeta,
        loggedByName.isAcceptableOrUnknown(
          data['logged_by_name']!,
          _loggedByNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_loggedByNameMeta);
    }
    if (data.containsKey('display_label')) {
      context.handle(
        _displayLabelMeta,
        displayLabel.isAcceptableOrUnknown(
          data['display_label']!,
          _displayLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayLabelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      petId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet_id'],
      )!,
      systemComponents: $EventsTable.$convertersystemComponents.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}system_components'],
        )!,
      ),
      customBlueprintIds: $EventsTable.$convertercustomBlueprintIds.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}custom_blueprint_ids'],
        )!,
      ),
      timestamp: $EventsTable.$convertertimestamp.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}timestamp'],
        )!,
      ),
      loggedByName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logged_by_name'],
      )!,
      displayLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_label'],
      )!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertersystemComponents =
      const StringListConverter();
  static TypeConverter<List<int>, String> $convertercustomBlueprintIds =
      const IntListConverter();
  static TypeConverter<DateTime, int> $convertertimestamp =
      const DateTimeConverter();
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final int petId;
  final List<String> systemComponents;
  final List<int> customBlueprintIds;
  final DateTime timestamp;
  final String loggedByName;
  final String displayLabel;
  const Event({
    required this.id,
    required this.petId,
    required this.systemComponents,
    required this.customBlueprintIds,
    required this.timestamp,
    required this.loggedByName,
    required this.displayLabel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pet_id'] = Variable<int>(petId);
    {
      map['system_components'] = Variable<String>(
        $EventsTable.$convertersystemComponents.toSql(systemComponents),
      );
    }
    {
      map['custom_blueprint_ids'] = Variable<String>(
        $EventsTable.$convertercustomBlueprintIds.toSql(customBlueprintIds),
      );
    }
    {
      map['timestamp'] = Variable<int>(
        $EventsTable.$convertertimestamp.toSql(timestamp),
      );
    }
    map['logged_by_name'] = Variable<String>(loggedByName);
    map['display_label'] = Variable<String>(displayLabel);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      petId: Value(petId),
      systemComponents: Value(systemComponents),
      customBlueprintIds: Value(customBlueprintIds),
      timestamp: Value(timestamp),
      loggedByName: Value(loggedByName),
      displayLabel: Value(displayLabel),
    );
  }

  factory Event.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      petId: serializer.fromJson<int>(json['petId']),
      systemComponents: serializer.fromJson<List<String>>(
        json['systemComponents'],
      ),
      customBlueprintIds: serializer.fromJson<List<int>>(
        json['customBlueprintIds'],
      ),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      loggedByName: serializer.fromJson<String>(json['loggedByName']),
      displayLabel: serializer.fromJson<String>(json['displayLabel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'petId': serializer.toJson<int>(petId),
      'systemComponents': serializer.toJson<List<String>>(systemComponents),
      'customBlueprintIds': serializer.toJson<List<int>>(customBlueprintIds),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'loggedByName': serializer.toJson<String>(loggedByName),
      'displayLabel': serializer.toJson<String>(displayLabel),
    };
  }

  Event copyWith({
    int? id,
    int? petId,
    List<String>? systemComponents,
    List<int>? customBlueprintIds,
    DateTime? timestamp,
    String? loggedByName,
    String? displayLabel,
  }) => Event(
    id: id ?? this.id,
    petId: petId ?? this.petId,
    systemComponents: systemComponents ?? this.systemComponents,
    customBlueprintIds: customBlueprintIds ?? this.customBlueprintIds,
    timestamp: timestamp ?? this.timestamp,
    loggedByName: loggedByName ?? this.loggedByName,
    displayLabel: displayLabel ?? this.displayLabel,
  );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      systemComponents: data.systemComponents.present
          ? data.systemComponents.value
          : this.systemComponents,
      customBlueprintIds: data.customBlueprintIds.present
          ? data.customBlueprintIds.value
          : this.customBlueprintIds,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      loggedByName: data.loggedByName.present
          ? data.loggedByName.value
          : this.loggedByName,
      displayLabel: data.displayLabel.present
          ? data.displayLabel.value
          : this.displayLabel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('systemComponents: $systemComponents, ')
          ..write('customBlueprintIds: $customBlueprintIds, ')
          ..write('timestamp: $timestamp, ')
          ..write('loggedByName: $loggedByName, ')
          ..write('displayLabel: $displayLabel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    petId,
    systemComponents,
    customBlueprintIds,
    timestamp,
    loggedByName,
    displayLabel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.systemComponents == this.systemComponents &&
          other.customBlueprintIds == this.customBlueprintIds &&
          other.timestamp == this.timestamp &&
          other.loggedByName == this.loggedByName &&
          other.displayLabel == this.displayLabel);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<int> petId;
  final Value<List<String>> systemComponents;
  final Value<List<int>> customBlueprintIds;
  final Value<DateTime> timestamp;
  final Value<String> loggedByName;
  final Value<String> displayLabel;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.systemComponents = const Value.absent(),
    this.customBlueprintIds = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.loggedByName = const Value.absent(),
    this.displayLabel = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required int petId,
    required List<String> systemComponents,
    required List<int> customBlueprintIds,
    required DateTime timestamp,
    required String loggedByName,
    required String displayLabel,
  }) : petId = Value(petId),
       systemComponents = Value(systemComponents),
       customBlueprintIds = Value(customBlueprintIds),
       timestamp = Value(timestamp),
       loggedByName = Value(loggedByName),
       displayLabel = Value(displayLabel);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<int>? petId,
    Expression<String>? systemComponents,
    Expression<String>? customBlueprintIds,
    Expression<int>? timestamp,
    Expression<String>? loggedByName,
    Expression<String>? displayLabel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (systemComponents != null) 'system_components': systemComponents,
      if (customBlueprintIds != null)
        'custom_blueprint_ids': customBlueprintIds,
      if (timestamp != null) 'timestamp': timestamp,
      if (loggedByName != null) 'logged_by_name': loggedByName,
      if (displayLabel != null) 'display_label': displayLabel,
    });
  }

  EventsCompanion copyWith({
    Value<int>? id,
    Value<int>? petId,
    Value<List<String>>? systemComponents,
    Value<List<int>>? customBlueprintIds,
    Value<DateTime>? timestamp,
    Value<String>? loggedByName,
    Value<String>? displayLabel,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      systemComponents: systemComponents ?? this.systemComponents,
      customBlueprintIds: customBlueprintIds ?? this.customBlueprintIds,
      timestamp: timestamp ?? this.timestamp,
      loggedByName: loggedByName ?? this.loggedByName,
      displayLabel: displayLabel ?? this.displayLabel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<int>(petId.value);
    }
    if (systemComponents.present) {
      map['system_components'] = Variable<String>(
        $EventsTable.$convertersystemComponents.toSql(systemComponents.value),
      );
    }
    if (customBlueprintIds.present) {
      map['custom_blueprint_ids'] = Variable<String>(
        $EventsTable.$convertercustomBlueprintIds.toSql(
          customBlueprintIds.value,
        ),
      );
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(
        $EventsTable.$convertertimestamp.toSql(timestamp.value),
      );
    }
    if (loggedByName.present) {
      map['logged_by_name'] = Variable<String>(loggedByName.value);
    }
    if (displayLabel.present) {
      map['display_label'] = Variable<String>(displayLabel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('systemComponents: $systemComponents, ')
          ..write('customBlueprintIds: $customBlueprintIds, ')
          ..write('timestamp: $timestamp, ')
          ..write('loggedByName: $loggedByName, ')
          ..write('displayLabel: $displayLabel')
          ..write(')'))
        .toString();
  }
}

class $CustomBlueprintsTable extends CustomBlueprints
    with TableInfo<$CustomBlueprintsTable, CustomBlueprint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomBlueprintsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _petIdMeta = const VerificationMeta('petId');
  @override
  late final GeneratedColumn<int> petId = GeneratedColumn<int>(
    'pet_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _componentsJsonMeta = const VerificationMeta(
    'componentsJson',
  );
  @override
  late final GeneratedColumn<String> componentsJson = GeneratedColumn<String>(
    'components_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    petId,
    name,
    iconKey,
    componentsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_blueprints';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomBlueprint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pet_id')) {
      context.handle(
        _petIdMeta,
        petId.isAcceptableOrUnknown(data['pet_id']!, _petIdMeta),
      );
    } else if (isInserting) {
      context.missing(_petIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    }
    if (data.containsKey('components_json')) {
      context.handle(
        _componentsJsonMeta,
        componentsJson.isAcceptableOrUnknown(
          data['components_json']!,
          _componentsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_componentsJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomBlueprint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomBlueprint(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      petId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pet_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      ),
      componentsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}components_json'],
      )!,
    );
  }

  @override
  $CustomBlueprintsTable createAlias(String alias) {
    return $CustomBlueprintsTable(attachedDatabase, alias);
  }
}

class CustomBlueprint extends DataClass implements Insertable<CustomBlueprint> {
  final int id;
  final int petId;
  final String name;
  final String? iconKey;
  final String componentsJson;
  const CustomBlueprint({
    required this.id,
    required this.petId,
    required this.name,
    this.iconKey,
    required this.componentsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pet_id'] = Variable<int>(petId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || iconKey != null) {
      map['icon_key'] = Variable<String>(iconKey);
    }
    map['components_json'] = Variable<String>(componentsJson);
    return map;
  }

  CustomBlueprintsCompanion toCompanion(bool nullToAbsent) {
    return CustomBlueprintsCompanion(
      id: Value(id),
      petId: Value(petId),
      name: Value(name),
      iconKey: iconKey == null && nullToAbsent
          ? const Value.absent()
          : Value(iconKey),
      componentsJson: Value(componentsJson),
    );
  }

  factory CustomBlueprint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomBlueprint(
      id: serializer.fromJson<int>(json['id']),
      petId: serializer.fromJson<int>(json['petId']),
      name: serializer.fromJson<String>(json['name']),
      iconKey: serializer.fromJson<String?>(json['iconKey']),
      componentsJson: serializer.fromJson<String>(json['componentsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'petId': serializer.toJson<int>(petId),
      'name': serializer.toJson<String>(name),
      'iconKey': serializer.toJson<String?>(iconKey),
      'componentsJson': serializer.toJson<String>(componentsJson),
    };
  }

  CustomBlueprint copyWith({
    int? id,
    int? petId,
    String? name,
    Value<String?> iconKey = const Value.absent(),
    String? componentsJson,
  }) => CustomBlueprint(
    id: id ?? this.id,
    petId: petId ?? this.petId,
    name: name ?? this.name,
    iconKey: iconKey.present ? iconKey.value : this.iconKey,
    componentsJson: componentsJson ?? this.componentsJson,
  );
  CustomBlueprint copyWithCompanion(CustomBlueprintsCompanion data) {
    return CustomBlueprint(
      id: data.id.present ? data.id.value : this.id,
      petId: data.petId.present ? data.petId.value : this.petId,
      name: data.name.present ? data.name.value : this.name,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      componentsJson: data.componentsJson.present
          ? data.componentsJson.value
          : this.componentsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomBlueprint(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('name: $name, ')
          ..write('iconKey: $iconKey, ')
          ..write('componentsJson: $componentsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, petId, name, iconKey, componentsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomBlueprint &&
          other.id == this.id &&
          other.petId == this.petId &&
          other.name == this.name &&
          other.iconKey == this.iconKey &&
          other.componentsJson == this.componentsJson);
}

class CustomBlueprintsCompanion extends UpdateCompanion<CustomBlueprint> {
  final Value<int> id;
  final Value<int> petId;
  final Value<String> name;
  final Value<String?> iconKey;
  final Value<String> componentsJson;
  const CustomBlueprintsCompanion({
    this.id = const Value.absent(),
    this.petId = const Value.absent(),
    this.name = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.componentsJson = const Value.absent(),
  });
  CustomBlueprintsCompanion.insert({
    this.id = const Value.absent(),
    required int petId,
    required String name,
    this.iconKey = const Value.absent(),
    required String componentsJson,
  }) : petId = Value(petId),
       name = Value(name),
       componentsJson = Value(componentsJson);
  static Insertable<CustomBlueprint> custom({
    Expression<int>? id,
    Expression<int>? petId,
    Expression<String>? name,
    Expression<String>? iconKey,
    Expression<String>? componentsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (petId != null) 'pet_id': petId,
      if (name != null) 'name': name,
      if (iconKey != null) 'icon_key': iconKey,
      if (componentsJson != null) 'components_json': componentsJson,
    });
  }

  CustomBlueprintsCompanion copyWith({
    Value<int>? id,
    Value<int>? petId,
    Value<String>? name,
    Value<String?>? iconKey,
    Value<String>? componentsJson,
  }) {
    return CustomBlueprintsCompanion(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      name: name ?? this.name,
      iconKey: iconKey ?? this.iconKey,
      componentsJson: componentsJson ?? this.componentsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (petId.present) {
      map['pet_id'] = Variable<int>(petId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (componentsJson.present) {
      map['components_json'] = Variable<String>(componentsJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomBlueprintsCompanion(')
          ..write('id: $id, ')
          ..write('petId: $petId, ')
          ..write('name: $name, ')
          ..write('iconKey: $iconKey, ')
          ..write('componentsJson: $componentsJson')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PetsTable pets = $PetsTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $CustomBlueprintsTable customBlueprints = $CustomBlueprintsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pets,
    events,
    customBlueprints,
  ];
}

typedef $$PetsTableCreateCompanionBuilder =
    PetsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> species,
      Value<String?> breed,
      Value<int?> birthdate,
      Value<String?> photoPath,
    });
typedef $$PetsTableUpdateCompanionBuilder =
    PetsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> species,
      Value<String?> breed,
      Value<int?> birthdate,
      Value<String?> photoPath,
    });

class $$PetsTableFilterComposer extends Composer<_$AppDatabase, $PetsTable> {
  $$PetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get birthdate => $composableBuilder(
    column: $table.birthdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PetsTableOrderingComposer extends Composer<_$AppDatabase, $PetsTable> {
  $$PetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breed => $composableBuilder(
    column: $table.breed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get birthdate => $composableBuilder(
    column: $table.birthdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PetsTable> {
  $$PetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get species =>
      $composableBuilder(column: $table.species, builder: (column) => column);

  GeneratedColumn<String> get breed =>
      $composableBuilder(column: $table.breed, builder: (column) => column);

  GeneratedColumn<int> get birthdate =>
      $composableBuilder(column: $table.birthdate, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);
}

class $$PetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PetsTable,
          Pet,
          $$PetsTableFilterComposer,
          $$PetsTableOrderingComposer,
          $$PetsTableAnnotationComposer,
          $$PetsTableCreateCompanionBuilder,
          $$PetsTableUpdateCompanionBuilder,
          (Pet, BaseReferences<_$AppDatabase, $PetsTable, Pet>),
          Pet,
          PrefetchHooks Function()
        > {
  $$PetsTableTableManager(_$AppDatabase db, $PetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> species = const Value.absent(),
                Value<String?> breed = const Value.absent(),
                Value<int?> birthdate = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
              }) => PetsCompanion(
                id: id,
                name: name,
                species: species,
                breed: breed,
                birthdate: birthdate,
                photoPath: photoPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> species = const Value.absent(),
                Value<String?> breed = const Value.absent(),
                Value<int?> birthdate = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
              }) => PetsCompanion.insert(
                id: id,
                name: name,
                species: species,
                breed: breed,
                birthdate: birthdate,
                photoPath: photoPath,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PetsTable,
      Pet,
      $$PetsTableFilterComposer,
      $$PetsTableOrderingComposer,
      $$PetsTableAnnotationComposer,
      $$PetsTableCreateCompanionBuilder,
      $$PetsTableUpdateCompanionBuilder,
      (Pet, BaseReferences<_$AppDatabase, $PetsTable, Pet>),
      Pet,
      PrefetchHooks Function()
    >;
typedef $$EventsTableCreateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      required int petId,
      required List<String> systemComponents,
      required List<int> customBlueprintIds,
      required DateTime timestamp,
      required String loggedByName,
      required String displayLabel,
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      Value<int> petId,
      Value<List<String>> systemComponents,
      Value<List<int>> customBlueprintIds,
      Value<DateTime> timestamp,
      Value<String> loggedByName,
      Value<String> displayLabel,
    });

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get petId => $composableBuilder(
    column: $table.petId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get systemComponents => $composableBuilder(
    column: $table.systemComponents,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<int>, List<int>, String>
  get customBlueprintIds => $composableBuilder(
    column: $table.customBlueprintIds,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<DateTime, DateTime, int> get timestamp =>
      $composableBuilder(
        column: $table.timestamp,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get loggedByName => $composableBuilder(
    column: $table.loggedByName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayLabel => $composableBuilder(
    column: $table.displayLabel,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get petId => $composableBuilder(
    column: $table.petId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systemComponents => $composableBuilder(
    column: $table.systemComponents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customBlueprintIds => $composableBuilder(
    column: $table.customBlueprintIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loggedByName => $composableBuilder(
    column: $table.loggedByName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayLabel => $composableBuilder(
    column: $table.displayLabel,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get petId =>
      $composableBuilder(column: $table.petId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get systemComponents =>
      $composableBuilder(
        column: $table.systemComponents,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<int>, String> get customBlueprintIds =>
      $composableBuilder(
        column: $table.customBlueprintIds,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<DateTime, int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get loggedByName => $composableBuilder(
    column: $table.loggedByName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayLabel => $composableBuilder(
    column: $table.displayLabel,
    builder: (column) => column,
  );
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsTable,
          Event,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (Event, BaseReferences<_$AppDatabase, $EventsTable, Event>),
          Event,
          PrefetchHooks Function()
        > {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> petId = const Value.absent(),
                Value<List<String>> systemComponents = const Value.absent(),
                Value<List<int>> customBlueprintIds = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> loggedByName = const Value.absent(),
                Value<String> displayLabel = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                petId: petId,
                systemComponents: systemComponents,
                customBlueprintIds: customBlueprintIds,
                timestamp: timestamp,
                loggedByName: loggedByName,
                displayLabel: displayLabel,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int petId,
                required List<String> systemComponents,
                required List<int> customBlueprintIds,
                required DateTime timestamp,
                required String loggedByName,
                required String displayLabel,
              }) => EventsCompanion.insert(
                id: id,
                petId: petId,
                systemComponents: systemComponents,
                customBlueprintIds: customBlueprintIds,
                timestamp: timestamp,
                loggedByName: loggedByName,
                displayLabel: displayLabel,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsTable,
      Event,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (Event, BaseReferences<_$AppDatabase, $EventsTable, Event>),
      Event,
      PrefetchHooks Function()
    >;
typedef $$CustomBlueprintsTableCreateCompanionBuilder =
    CustomBlueprintsCompanion Function({
      Value<int> id,
      required int petId,
      required String name,
      Value<String?> iconKey,
      required String componentsJson,
    });
typedef $$CustomBlueprintsTableUpdateCompanionBuilder =
    CustomBlueprintsCompanion Function({
      Value<int> id,
      Value<int> petId,
      Value<String> name,
      Value<String?> iconKey,
      Value<String> componentsJson,
    });

class $$CustomBlueprintsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomBlueprintsTable> {
  $$CustomBlueprintsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get petId => $composableBuilder(
    column: $table.petId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get componentsJson => $composableBuilder(
    column: $table.componentsJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomBlueprintsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomBlueprintsTable> {
  $$CustomBlueprintsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get petId => $composableBuilder(
    column: $table.petId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get componentsJson => $composableBuilder(
    column: $table.componentsJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomBlueprintsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomBlueprintsTable> {
  $$CustomBlueprintsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get petId =>
      $composableBuilder(column: $table.petId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<String> get componentsJson => $composableBuilder(
    column: $table.componentsJson,
    builder: (column) => column,
  );
}

class $$CustomBlueprintsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomBlueprintsTable,
          CustomBlueprint,
          $$CustomBlueprintsTableFilterComposer,
          $$CustomBlueprintsTableOrderingComposer,
          $$CustomBlueprintsTableAnnotationComposer,
          $$CustomBlueprintsTableCreateCompanionBuilder,
          $$CustomBlueprintsTableUpdateCompanionBuilder,
          (
            CustomBlueprint,
            BaseReferences<
              _$AppDatabase,
              $CustomBlueprintsTable,
              CustomBlueprint
            >,
          ),
          CustomBlueprint,
          PrefetchHooks Function()
        > {
  $$CustomBlueprintsTableTableManager(
    _$AppDatabase db,
    $CustomBlueprintsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomBlueprintsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomBlueprintsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomBlueprintsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> petId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> iconKey = const Value.absent(),
                Value<String> componentsJson = const Value.absent(),
              }) => CustomBlueprintsCompanion(
                id: id,
                petId: petId,
                name: name,
                iconKey: iconKey,
                componentsJson: componentsJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int petId,
                required String name,
                Value<String?> iconKey = const Value.absent(),
                required String componentsJson,
              }) => CustomBlueprintsCompanion.insert(
                id: id,
                petId: petId,
                name: name,
                iconKey: iconKey,
                componentsJson: componentsJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomBlueprintsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomBlueprintsTable,
      CustomBlueprint,
      $$CustomBlueprintsTableFilterComposer,
      $$CustomBlueprintsTableOrderingComposer,
      $$CustomBlueprintsTableAnnotationComposer,
      $$CustomBlueprintsTableCreateCompanionBuilder,
      $$CustomBlueprintsTableUpdateCompanionBuilder,
      (
        CustomBlueprint,
        BaseReferences<_$AppDatabase, $CustomBlueprintsTable, CustomBlueprint>,
      ),
      CustomBlueprint,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PetsTableTableManager get pets => $$PetsTableTableManager(_db, _db.pets);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$CustomBlueprintsTableTableManager get customBlueprints =>
      $$CustomBlueprintsTableTableManager(_db, _db.customBlueprints);
}
