// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DrinkCategoriesTable extends DrinkCategories
    with TableInfo<$DrinkCategoriesTable, DrinkCategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrinkCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hydrationFactorMeta = const VerificationMeta(
    'hydrationFactor',
  );
  @override
  late final GeneratedColumn<double> hydrationFactor = GeneratedColumn<double>(
    'hydration_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    colorValue,
    hydrationFactor,
    sortOrder,
    updatedAt,
    deviceId,
    deleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drink_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<DrinkCategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('hydration_factor')) {
      context.handle(
        _hydrationFactorMeta,
        hydrationFactor.isAcceptableOrUnknown(
          data['hydration_factor']!,
          _hydrationFactorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hydrationFactorMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrinkCategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrinkCategoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      hydrationFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hydration_factor'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
    );
  }

  @override
  $DrinkCategoriesTable createAlias(String alias) {
    return $DrinkCategoriesTable(attachedDatabase, alias);
  }
}

class DrinkCategoryRow extends DataClass
    implements Insertable<DrinkCategoryRow> {
  final String id;
  final String name;
  final int colorValue;
  final double hydrationFactor;
  final int sortOrder;
  final DateTime updatedAt;
  final String deviceId;
  final bool deleted;
  const DrinkCategoryRow({
    required this.id,
    required this.name,
    required this.colorValue,
    required this.hydrationFactor,
    required this.sortOrder,
    required this.updatedAt,
    required this.deviceId,
    required this.deleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color_value'] = Variable<int>(colorValue);
    map['hydration_factor'] = Variable<double>(hydrationFactor);
    map['sort_order'] = Variable<int>(sortOrder);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    map['deleted'] = Variable<bool>(deleted);
    return map;
  }

  DrinkCategoriesCompanion toCompanion(bool nullToAbsent) {
    return DrinkCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      colorValue: Value(colorValue),
      hydrationFactor: Value(hydrationFactor),
      sortOrder: Value(sortOrder),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
      deleted: Value(deleted),
    );
  }

  factory DrinkCategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrinkCategoryRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      hydrationFactor: serializer.fromJson<double>(json['hydrationFactor']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      deleted: serializer.fromJson<bool>(json['deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'colorValue': serializer.toJson<int>(colorValue),
      'hydrationFactor': serializer.toJson<double>(hydrationFactor),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
      'deleted': serializer.toJson<bool>(deleted),
    };
  }

  DrinkCategoryRow copyWith({
    String? id,
    String? name,
    int? colorValue,
    double? hydrationFactor,
    int? sortOrder,
    DateTime? updatedAt,
    String? deviceId,
    bool? deleted,
  }) => DrinkCategoryRow(
    id: id ?? this.id,
    name: name ?? this.name,
    colorValue: colorValue ?? this.colorValue,
    hydrationFactor: hydrationFactor ?? this.hydrationFactor,
    sortOrder: sortOrder ?? this.sortOrder,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
    deleted: deleted ?? this.deleted,
  );
  DrinkCategoryRow copyWithCompanion(DrinkCategoriesCompanion data) {
    return DrinkCategoryRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      hydrationFactor: data.hydrationFactor.present
          ? data.hydrationFactor.value
          : this.hydrationFactor,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrinkCategoryRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('hydrationFactor: $hydrationFactor, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    colorValue,
    hydrationFactor,
    sortOrder,
    updatedAt,
    deviceId,
    deleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrinkCategoryRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorValue == this.colorValue &&
          other.hydrationFactor == this.hydrationFactor &&
          other.sortOrder == this.sortOrder &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId &&
          other.deleted == this.deleted);
}

class DrinkCategoriesCompanion extends UpdateCompanion<DrinkCategoryRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> colorValue;
  final Value<double> hydrationFactor;
  final Value<int> sortOrder;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  final Value<bool> deleted;
  final Value<int> rowid;
  const DrinkCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.hydrationFactor = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.deleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrinkCategoriesCompanion.insert({
    required String id,
    required String name,
    required int colorValue,
    required double hydrationFactor,
    required int sortOrder,
    required DateTime updatedAt,
    required String deviceId,
    this.deleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       colorValue = Value(colorValue),
       hydrationFactor = Value(hydrationFactor),
       sortOrder = Value(sortOrder),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<DrinkCategoryRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? colorValue,
    Expression<double>? hydrationFactor,
    Expression<int>? sortOrder,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
    Expression<bool>? deleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorValue != null) 'color_value': colorValue,
      if (hydrationFactor != null) 'hydration_factor': hydrationFactor,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
      if (deleted != null) 'deleted': deleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrinkCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? colorValue,
    Value<double>? hydrationFactor,
    Value<int>? sortOrder,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
    Value<bool>? deleted,
    Value<int>? rowid,
  }) {
    return DrinkCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      hydrationFactor: hydrationFactor ?? this.hydrationFactor,
      sortOrder: sortOrder ?? this.sortOrder,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
      deleted: deleted ?? this.deleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (hydrationFactor.present) {
      map['hydration_factor'] = Variable<double>(hydrationFactor.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrinkCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorValue: $colorValue, ')
          ..write('hydrationFactor: $hydrationFactor, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('deleted: $deleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DrinksTable extends Drinks with TableInfo<$DrinksTable, DrinkRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES drink_categories (id)',
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
  static const VerificationMeta _volumeMlMeta = const VerificationMeta(
    'volumeMl',
  );
  @override
  late final GeneratedColumn<int> volumeMl = GeneratedColumn<int>(
    'volume_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _starredMeta = const VerificationMeta(
    'starred',
  );
  @override
  late final GeneratedColumn<bool> starred = GeneratedColumn<bool>(
    'starred',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("starred" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    name,
    volumeMl,
    starred,
    updatedAt,
    deviceId,
    deleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drinks';
  @override
  VerificationContext validateIntegrity(
    Insertable<DrinkRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('volume_ml')) {
      context.handle(
        _volumeMlMeta,
        volumeMl.isAcceptableOrUnknown(data['volume_ml']!, _volumeMlMeta),
      );
    } else if (isInserting) {
      context.missing(_volumeMlMeta);
    }
    if (data.containsKey('starred')) {
      context.handle(
        _starredMeta,
        starred.isAcceptableOrUnknown(data['starred']!, _starredMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrinkRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrinkRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      volumeMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}volume_ml'],
      )!,
      starred: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}starred'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
    );
  }

  @override
  $DrinksTable createAlias(String alias) {
    return $DrinksTable(attachedDatabase, alias);
  }
}

class DrinkRow extends DataClass implements Insertable<DrinkRow> {
  final String id;
  final String categoryId;
  final String name;
  final int volumeMl;
  final bool starred;
  final DateTime updatedAt;
  final String deviceId;
  final bool deleted;
  const DrinkRow({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.volumeMl,
    required this.starred,
    required this.updatedAt,
    required this.deviceId,
    required this.deleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['name'] = Variable<String>(name);
    map['volume_ml'] = Variable<int>(volumeMl);
    map['starred'] = Variable<bool>(starred);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    map['deleted'] = Variable<bool>(deleted);
    return map;
  }

  DrinksCompanion toCompanion(bool nullToAbsent) {
    return DrinksCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      name: Value(name),
      volumeMl: Value(volumeMl),
      starred: Value(starred),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
      deleted: Value(deleted),
    );
  }

  factory DrinkRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrinkRow(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      volumeMl: serializer.fromJson<int>(json['volumeMl']),
      starred: serializer.fromJson<bool>(json['starred']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      deleted: serializer.fromJson<bool>(json['deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'name': serializer.toJson<String>(name),
      'volumeMl': serializer.toJson<int>(volumeMl),
      'starred': serializer.toJson<bool>(starred),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
      'deleted': serializer.toJson<bool>(deleted),
    };
  }

  DrinkRow copyWith({
    String? id,
    String? categoryId,
    String? name,
    int? volumeMl,
    bool? starred,
    DateTime? updatedAt,
    String? deviceId,
    bool? deleted,
  }) => DrinkRow(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    name: name ?? this.name,
    volumeMl: volumeMl ?? this.volumeMl,
    starred: starred ?? this.starred,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
    deleted: deleted ?? this.deleted,
  );
  DrinkRow copyWithCompanion(DrinksCompanion data) {
    return DrinkRow(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      volumeMl: data.volumeMl.present ? data.volumeMl.value : this.volumeMl,
      starred: data.starred.present ? data.starred.value : this.starred,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrinkRow(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('starred: $starred, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    name,
    volumeMl,
    starred,
    updatedAt,
    deviceId,
    deleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrinkRow &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.volumeMl == this.volumeMl &&
          other.starred == this.starred &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId &&
          other.deleted == this.deleted);
}

class DrinksCompanion extends UpdateCompanion<DrinkRow> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<String> name;
  final Value<int> volumeMl;
  final Value<bool> starred;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  final Value<bool> deleted;
  final Value<int> rowid;
  const DrinksCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.volumeMl = const Value.absent(),
    this.starred = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.deleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrinksCompanion.insert({
    required String id,
    required String categoryId,
    required String name,
    required int volumeMl,
    this.starred = const Value.absent(),
    required DateTime updatedAt,
    required String deviceId,
    this.deleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       categoryId = Value(categoryId),
       name = Value(name),
       volumeMl = Value(volumeMl),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<DrinkRow> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<String>? name,
    Expression<int>? volumeMl,
    Expression<bool>? starred,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
    Expression<bool>? deleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (volumeMl != null) 'volume_ml': volumeMl,
      if (starred != null) 'starred': starred,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
      if (deleted != null) 'deleted': deleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrinksCompanion copyWith({
    Value<String>? id,
    Value<String>? categoryId,
    Value<String>? name,
    Value<int>? volumeMl,
    Value<bool>? starred,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
    Value<bool>? deleted,
    Value<int>? rowid,
  }) {
    return DrinksCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      volumeMl: volumeMl ?? this.volumeMl,
      starred: starred ?? this.starred,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
      deleted: deleted ?? this.deleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (volumeMl.present) {
      map['volume_ml'] = Variable<int>(volumeMl.value);
    }
    if (starred.present) {
      map['starred'] = Variable<bool>(starred.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrinksCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('starred: $starred, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('deleted: $deleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LogEntriesTable extends LogEntries
    with TableInfo<$LogEntriesTable, LogEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES drink_categories (id)',
    ),
  );
  static const VerificationMeta _volumeMlMeta = const VerificationMeta(
    'volumeMl',
  );
  @override
  late final GeneratedColumn<int> volumeMl = GeneratedColumn<int>(
    'volume_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedMeta = const VerificationMeta(
    'deleted',
  );
  @override
  late final GeneratedColumn<bool> deleted = GeneratedColumn<bool>(
    'deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    volumeMl,
    loggedAt,
    updatedAt,
    deviceId,
    deleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'log_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('volume_ml')) {
      context.handle(
        _volumeMlMeta,
        volumeMl.isAcceptableOrUnknown(data['volume_ml']!, _volumeMlMeta),
      );
    } else if (isInserting) {
      context.missing(_volumeMlMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('deleted')) {
      context.handle(
        _deletedMeta,
        deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      volumeMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}volume_ml'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      deleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deleted'],
      )!,
    );
  }

  @override
  $LogEntriesTable createAlias(String alias) {
    return $LogEntriesTable(attachedDatabase, alias);
  }
}

class LogEntryRow extends DataClass implements Insertable<LogEntryRow> {
  final String id;
  final String categoryId;
  final int volumeMl;
  final DateTime loggedAt;
  final DateTime updatedAt;
  final String deviceId;
  final bool deleted;
  const LogEntryRow({
    required this.id,
    required this.categoryId,
    required this.volumeMl,
    required this.loggedAt,
    required this.updatedAt,
    required this.deviceId,
    required this.deleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['volume_ml'] = Variable<int>(volumeMl);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['device_id'] = Variable<String>(deviceId);
    map['deleted'] = Variable<bool>(deleted);
    return map;
  }

  LogEntriesCompanion toCompanion(bool nullToAbsent) {
    return LogEntriesCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      volumeMl: Value(volumeMl),
      loggedAt: Value(loggedAt),
      updatedAt: Value(updatedAt),
      deviceId: Value(deviceId),
      deleted: Value(deleted),
    );
  }

  factory LogEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogEntryRow(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      volumeMl: serializer.fromJson<int>(json['volumeMl']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      deleted: serializer.fromJson<bool>(json['deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'volumeMl': serializer.toJson<int>(volumeMl),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deviceId': serializer.toJson<String>(deviceId),
      'deleted': serializer.toJson<bool>(deleted),
    };
  }

  LogEntryRow copyWith({
    String? id,
    String? categoryId,
    int? volumeMl,
    DateTime? loggedAt,
    DateTime? updatedAt,
    String? deviceId,
    bool? deleted,
  }) => LogEntryRow(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    volumeMl: volumeMl ?? this.volumeMl,
    loggedAt: loggedAt ?? this.loggedAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deviceId: deviceId ?? this.deviceId,
    deleted: deleted ?? this.deleted,
  );
  LogEntryRow copyWithCompanion(LogEntriesCompanion data) {
    return LogEntryRow(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      volumeMl: data.volumeMl.present ? data.volumeMl.value : this.volumeMl,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      deleted: data.deleted.present ? data.deleted.value : this.deleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogEntryRow(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('deleted: $deleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    volumeMl,
    loggedAt,
    updatedAt,
    deviceId,
    deleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogEntryRow &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.volumeMl == this.volumeMl &&
          other.loggedAt == this.loggedAt &&
          other.updatedAt == this.updatedAt &&
          other.deviceId == this.deviceId &&
          other.deleted == this.deleted);
}

class LogEntriesCompanion extends UpdateCompanion<LogEntryRow> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<int> volumeMl;
  final Value<DateTime> loggedAt;
  final Value<DateTime> updatedAt;
  final Value<String> deviceId;
  final Value<bool> deleted;
  final Value<int> rowid;
  const LogEntriesCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.volumeMl = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.deleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LogEntriesCompanion.insert({
    required String id,
    required String categoryId,
    required int volumeMl,
    required DateTime loggedAt,
    required DateTime updatedAt,
    required String deviceId,
    this.deleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       categoryId = Value(categoryId),
       volumeMl = Value(volumeMl),
       loggedAt = Value(loggedAt),
       updatedAt = Value(updatedAt),
       deviceId = Value(deviceId);
  static Insertable<LogEntryRow> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<int>? volumeMl,
    Expression<DateTime>? loggedAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? deviceId,
    Expression<bool>? deleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (volumeMl != null) 'volume_ml': volumeMl,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deviceId != null) 'device_id': deviceId,
      if (deleted != null) 'deleted': deleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LogEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? categoryId,
    Value<int>? volumeMl,
    Value<DateTime>? loggedAt,
    Value<DateTime>? updatedAt,
    Value<String>? deviceId,
    Value<bool>? deleted,
    Value<int>? rowid,
  }) {
    return LogEntriesCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      volumeMl: volumeMl ?? this.volumeMl,
      loggedAt: loggedAt ?? this.loggedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceId: deviceId ?? this.deviceId,
      deleted: deleted ?? this.deleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (volumeMl.present) {
      map['volume_ml'] = Variable<int>(volumeMl.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<bool>(deleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogEntriesCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('deleted: $deleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, SettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingRow extends DataClass implements Insertable<SettingRow> {
  final String key;
  final String value;
  const SettingRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(key: Value(key), value: Value(value));
  }

  factory SettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SettingRow copyWith({String? key, String? value}) =>
      SettingRow(key: key ?? this.key, value: value ?? this.value);
  SettingRow copyWithCompanion(SettingsCompanion data) {
    return SettingRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingRow &&
          other.key == this.key &&
          other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<SettingRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SettingRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DrinkCategoriesTable drinkCategories = $DrinkCategoriesTable(
    this,
  );
  late final $DrinksTable drinks = $DrinksTable(this);
  late final $LogEntriesTable logEntries = $LogEntriesTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    drinkCategories,
    drinks,
    logEntries,
    settings,
  ];
}

typedef $$DrinkCategoriesTableCreateCompanionBuilder =
    DrinkCategoriesCompanion Function({
      required String id,
      required String name,
      required int colorValue,
      required double hydrationFactor,
      required int sortOrder,
      required DateTime updatedAt,
      required String deviceId,
      Value<bool> deleted,
      Value<int> rowid,
    });
typedef $$DrinkCategoriesTableUpdateCompanionBuilder =
    DrinkCategoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> colorValue,
      Value<double> hydrationFactor,
      Value<int> sortOrder,
      Value<DateTime> updatedAt,
      Value<String> deviceId,
      Value<bool> deleted,
      Value<int> rowid,
    });

final class $$DrinkCategoriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $DrinkCategoriesTable, DrinkCategoryRow> {
  $$DrinkCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$DrinksTable, List<DrinkRow>> _drinksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.drinks,
    aliasName: 'drink_categories__id__drinks__category_id',
  );

  $$DrinksTableProcessedTableManager get drinksRefs {
    final manager = $$DrinksTableTableManager(
      $_db,
      $_db.drinks,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_drinksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LogEntriesTable, List<LogEntryRow>>
  _logEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.logEntries,
    aliasName: 'drink_categories__id__log_entries__category_id',
  );

  $$LogEntriesTableProcessedTableManager get logEntriesRefs {
    final manager = $$LogEntriesTableTableManager(
      $_db,
      $_db.logEntries,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_logEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DrinkCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $DrinkCategoriesTable> {
  $$DrinkCategoriesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hydrationFactor => $composableBuilder(
    column: $table.hydrationFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> drinksRefs(
    Expression<bool> Function($$DrinksTableFilterComposer f) f,
  ) {
    final $$DrinksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drinks,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinksTableFilterComposer(
            $db: $db,
            $table: $db.drinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> logEntriesRefs(
    Expression<bool> Function($$LogEntriesTableFilterComposer f) f,
  ) {
    final $$LogEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logEntries,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableFilterComposer(
            $db: $db,
            $table: $db.logEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DrinkCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DrinkCategoriesTable> {
  $$DrinkCategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hydrationFactor => $composableBuilder(
    column: $table.hydrationFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DrinkCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrinkCategoriesTable> {
  $$DrinkCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get hydrationFactor => $composableBuilder(
    column: $table.hydrationFactor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  Expression<T> drinksRefs<T extends Object>(
    Expression<T> Function($$DrinksTableAnnotationComposer a) f,
  ) {
    final $$DrinksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drinks,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinksTableAnnotationComposer(
            $db: $db,
            $table: $db.drinks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> logEntriesRefs<T extends Object>(
    Expression<T> Function($$LogEntriesTableAnnotationComposer a) f,
  ) {
    final $$LogEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logEntries,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.logEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DrinkCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DrinkCategoriesTable,
          DrinkCategoryRow,
          $$DrinkCategoriesTableFilterComposer,
          $$DrinkCategoriesTableOrderingComposer,
          $$DrinkCategoriesTableAnnotationComposer,
          $$DrinkCategoriesTableCreateCompanionBuilder,
          $$DrinkCategoriesTableUpdateCompanionBuilder,
          (DrinkCategoryRow, $$DrinkCategoriesTableReferences),
          DrinkCategoryRow,
          PrefetchHooks Function({bool drinksRefs, bool logEntriesRefs})
        > {
  $$DrinkCategoriesTableTableManager(
    _$AppDatabase db,
    $DrinkCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrinkCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrinkCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrinkCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<double> hydrationFactor = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DrinkCategoriesCompanion(
                id: id,
                name: name,
                colorValue: colorValue,
                hydrationFactor: hydrationFactor,
                sortOrder: sortOrder,
                updatedAt: updatedAt,
                deviceId: deviceId,
                deleted: deleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int colorValue,
                required double hydrationFactor,
                required int sortOrder,
                required DateTime updatedAt,
                required String deviceId,
                Value<bool> deleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DrinkCategoriesCompanion.insert(
                id: id,
                name: name,
                colorValue: colorValue,
                hydrationFactor: hydrationFactor,
                sortOrder: sortOrder,
                updatedAt: updatedAt,
                deviceId: deviceId,
                deleted: deleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DrinkCategoriesTable, DrinkCategoryRow>(table),
                  $$DrinkCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({drinksRefs = false, logEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (drinksRefs) db.drinks,
                    if (logEntriesRefs) db.logEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (drinksRefs)
                        await $_getPrefetchedDataByColumns<
                          DrinkCategoryRow,
                          $DrinkCategoriesTable,
                          DrinkRow,
                          $DrinksTable
                        >(
                          currentTable: table,
                          referencedTable: $$DrinkCategoriesTableReferences
                              ._drinksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DrinkCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).drinksRefs,
                          currentColumn: 'id',
                          referencedColumn: 'category_id',
                          typedResults: items,
                        ),
                      if (logEntriesRefs)
                        await $_getPrefetchedDataByColumns<
                          DrinkCategoryRow,
                          $DrinkCategoriesTable,
                          LogEntryRow,
                          $LogEntriesTable
                        >(
                          currentTable: table,
                          referencedTable: $$DrinkCategoriesTableReferences
                              ._logEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DrinkCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).logEntriesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'category_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DrinkCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DrinkCategoriesTable,
      DrinkCategoryRow,
      $$DrinkCategoriesTableFilterComposer,
      $$DrinkCategoriesTableOrderingComposer,
      $$DrinkCategoriesTableAnnotationComposer,
      $$DrinkCategoriesTableCreateCompanionBuilder,
      $$DrinkCategoriesTableUpdateCompanionBuilder,
      (DrinkCategoryRow, $$DrinkCategoriesTableReferences),
      DrinkCategoryRow,
      PrefetchHooks Function({bool drinksRefs, bool logEntriesRefs})
    >;
typedef $$DrinksTableCreateCompanionBuilder = DrinksCompanion Function({
  required String id,
  required String categoryId,
  required String name,
  required int volumeMl,
  Value<bool> starred,
  required DateTime updatedAt,
  required String deviceId,
  Value<bool> deleted,
  Value<int> rowid,
});
typedef $$DrinksTableUpdateCompanionBuilder = DrinksCompanion Function({
  Value<String> id,
  Value<String> categoryId,
  Value<String> name,
  Value<int> volumeMl,
  Value<bool> starred,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
  Value<bool> deleted,
  Value<int> rowid,
});

final class $$DrinksTableReferences
    extends BaseReferences<_$AppDatabase, $DrinksTable, DrinkRow> {
  $$DrinksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DrinkCategoriesTable _categoryIdTable(_$AppDatabase db) => db
      .drinkCategories
      .createAlias('drinks__category_id__drink_categories__id');

  $$DrinkCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$DrinkCategoriesTableTableManager(
      $_db,
      $_db.drinkCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DrinksTableFilterComposer
    extends Composer<_$AppDatabase, $DrinksTable> {
  $$DrinksTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get volumeMl => $composableBuilder(
    column: $table.volumeMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get starred => $composableBuilder(
    column: $table.starred,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  $$DrinkCategoriesTableFilterComposer get categoryId {
    final $$DrinkCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.drinkCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinkCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.drinkCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DrinksTableOrderingComposer
    extends Composer<_$AppDatabase, $DrinksTable> {
  $$DrinksTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get volumeMl => $composableBuilder(
    column: $table.volumeMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get starred => $composableBuilder(
    column: $table.starred,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$DrinkCategoriesTableOrderingComposer get categoryId {
    final $$DrinkCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.drinkCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinkCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.drinkCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DrinksTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrinksTable> {
  $$DrinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get volumeMl =>
      $composableBuilder(column: $table.volumeMl, builder: (column) => column);

  GeneratedColumn<bool> get starred =>
      $composableBuilder(column: $table.starred, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  $$DrinkCategoriesTableAnnotationComposer get categoryId {
    final $$DrinkCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.drinkCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinkCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.drinkCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DrinksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DrinksTable,
          DrinkRow,
          $$DrinksTableFilterComposer,
          $$DrinksTableOrderingComposer,
          $$DrinksTableAnnotationComposer,
          $$DrinksTableCreateCompanionBuilder,
          $$DrinksTableUpdateCompanionBuilder,
          (DrinkRow, $$DrinksTableReferences),
          DrinkRow,
          PrefetchHooks Function({bool categoryId})
        > {
  $$DrinksTableTableManager(_$AppDatabase db, $DrinksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> volumeMl = const Value.absent(),
                Value<bool> starred = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DrinksCompanion(
                id: id,
                categoryId: categoryId,
                name: name,
                volumeMl: volumeMl,
                starred: starred,
                updatedAt: updatedAt,
                deviceId: deviceId,
                deleted: deleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String categoryId,
                required String name,
                required int volumeMl,
                Value<bool> starred = const Value.absent(),
                required DateTime updatedAt,
                required String deviceId,
                Value<bool> deleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DrinksCompanion.insert(
                id: id,
                categoryId: categoryId,
                name: name,
                volumeMl: volumeMl,
                starred: starred,
                updatedAt: updatedAt,
                deviceId: deviceId,
                deleted: deleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DrinksTable, DrinkRow>(table),
                  $$DrinksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$DrinksTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$DrinksTableReferences
                            ._categoryIdTable(db)
                            .id,
                      ) as T;
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

typedef $$DrinksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DrinksTable,
      DrinkRow,
      $$DrinksTableFilterComposer,
      $$DrinksTableOrderingComposer,
      $$DrinksTableAnnotationComposer,
      $$DrinksTableCreateCompanionBuilder,
      $$DrinksTableUpdateCompanionBuilder,
      (DrinkRow, $$DrinksTableReferences),
      DrinkRow,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$LogEntriesTableCreateCompanionBuilder = LogEntriesCompanion Function({
  required String id,
  required String categoryId,
  required int volumeMl,
  required DateTime loggedAt,
  required DateTime updatedAt,
  required String deviceId,
  Value<bool> deleted,
  Value<int> rowid,
});
typedef $$LogEntriesTableUpdateCompanionBuilder = LogEntriesCompanion Function({
  Value<String> id,
  Value<String> categoryId,
  Value<int> volumeMl,
  Value<DateTime> loggedAt,
  Value<DateTime> updatedAt,
  Value<String> deviceId,
  Value<bool> deleted,
  Value<int> rowid,
});

final class $$LogEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $LogEntriesTable, LogEntryRow> {
  $$LogEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DrinkCategoriesTable _categoryIdTable(_$AppDatabase db) => db
      .drinkCategories
      .createAlias('log_entries__category_id__drink_categories__id');

  $$DrinkCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$DrinkCategoriesTableTableManager(
      $_db,
      $_db.drinkCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LogEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableFilterComposer({
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

  ColumnFilters<int> get volumeMl => $composableBuilder(
    column: $table.volumeMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnFilters(column),
  );

  $$DrinkCategoriesTableFilterComposer get categoryId {
    final $$DrinkCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.drinkCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinkCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.drinkCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableOrderingComposer({
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

  ColumnOrderings<int> get volumeMl => $composableBuilder(
    column: $table.volumeMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleted => $composableBuilder(
    column: $table.deleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$DrinkCategoriesTableOrderingComposer get categoryId {
    final $$DrinkCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.drinkCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinkCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.drinkCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get volumeMl =>
      $composableBuilder(column: $table.volumeMl, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<bool> get deleted =>
      $composableBuilder(column: $table.deleted, builder: (column) => column);

  $$DrinkCategoriesTableAnnotationComposer get categoryId {
    final $$DrinkCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.drinkCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrinkCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.drinkCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LogEntriesTable,
          LogEntryRow,
          $$LogEntriesTableFilterComposer,
          $$LogEntriesTableOrderingComposer,
          $$LogEntriesTableAnnotationComposer,
          $$LogEntriesTableCreateCompanionBuilder,
          $$LogEntriesTableUpdateCompanionBuilder,
          (LogEntryRow, $$LogEntriesTableReferences),
          LogEntryRow,
          PrefetchHooks Function({bool categoryId})
        > {
  $$LogEntriesTableTableManager(_$AppDatabase db, $LogEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> volumeMl = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<bool> deleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LogEntriesCompanion(
                id: id,
                categoryId: categoryId,
                volumeMl: volumeMl,
                loggedAt: loggedAt,
                updatedAt: updatedAt,
                deviceId: deviceId,
                deleted: deleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String categoryId,
                required int volumeMl,
                required DateTime loggedAt,
                required DateTime updatedAt,
                required String deviceId,
                Value<bool> deleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LogEntriesCompanion.insert(
                id: id,
                categoryId: categoryId,
                volumeMl: volumeMl,
                loggedAt: loggedAt,
                updatedAt: updatedAt,
                deviceId: deviceId,
                deleted: deleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LogEntriesTable, LogEntryRow>(table),
                  $$LogEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$LogEntriesTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$LogEntriesTableReferences
                            ._categoryIdTable(db)
                            .id,
                      ) as T;
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

typedef $$LogEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LogEntriesTable,
      LogEntryRow,
      $$LogEntriesTableFilterComposer,
      $$LogEntriesTableOrderingComposer,
      $$LogEntriesTableAnnotationComposer,
      $$LogEntriesTableCreateCompanionBuilder,
      $$LogEntriesTableUpdateCompanionBuilder,
      (LogEntryRow, $$LogEntriesTableReferences),
      LogEntryRow,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          SettingRow,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (
            SettingRow,
            BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>,
          ),
          SettingRow,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => SettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => SettingsCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTable, SettingRow>(table),
                  BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      SettingRow,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (SettingRow, BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>),
      SettingRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DrinkCategoriesTableTableManager get drinkCategories =>
      $$DrinkCategoriesTableTableManager(_db, _db.drinkCategories);
  $$DrinksTableTableManager get drinks =>
      $$DrinksTableTableManager(_db, _db.drinks);
  $$LogEntriesTableTableManager get logEntries =>
      $$LogEntriesTableTableManager(_db, _db.logEntries);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
