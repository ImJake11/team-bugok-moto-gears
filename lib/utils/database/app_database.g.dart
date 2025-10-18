// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BrandsTable extends Brands with TableInfo<$BrandsTable, Brand> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrandsTable(this.attachedDatabase, [this._alias]);
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
  List<GeneratedColumn> get $columns => [id, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'brands';
  @override
  VerificationContext validateIntegrity(
    Insertable<Brand> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Brand map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Brand(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $BrandsTable createAlias(String alias) {
    return $BrandsTable(attachedDatabase, alias);
  }
}

class Brand extends DataClass implements Insertable<Brand> {
  final int id;
  final String value;
  const Brand({required this.id, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['value'] = Variable<String>(value);
    return map;
  }

  BrandsCompanion toCompanion(bool nullToAbsent) {
    return BrandsCompanion(id: Value(id), value: Value(value));
  }

  factory Brand.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Brand(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<String>(value),
    };
  }

  Brand copyWith({int? id, String? value}) =>
      Brand(id: id ?? this.id, value: value ?? this.value);
  Brand copyWithCompanion(BrandsCompanion data) {
    return Brand(
      id: data.id.present ? data.id.value : this.id,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Brand(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Brand && other.id == this.id && other.value == this.value);
}

class BrandsCompanion extends UpdateCompanion<Brand> {
  final Value<int> id;
  final Value<String> value;
  const BrandsCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
  });
  BrandsCompanion.insert({
    this.id = const Value.absent(),
    required String value,
  }) : value = Value(value);
  static Insertable<Brand> custom({
    Expression<int>? id,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
    });
  }

  BrandsCompanion copyWith({Value<int>? id, Value<String>? value}) {
    return BrandsCompanion(id: id ?? this.id, value: value ?? this.value);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrandsCompanion(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
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
  List<GeneratedColumn> get $columns => [id, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String value;
  const Category({required this.id, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['value'] = Variable<String>(value);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(id: Value(id), value: Value(value));
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<String>(value),
    };
  }

  Category copyWith({int? id, String? value}) =>
      Category(id: id ?? this.id, value: value ?? this.value);
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category && other.id == this.id && other.value == this.value);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> value;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String value,
  }) : value = Value(value);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
    });
  }

  CategoriesCompanion copyWith({Value<int>? id, Value<String>? value}) {
    return CategoriesCompanion(id: id ?? this.id, value: value ?? this.value);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<int> brand = GeneratedColumn<int>(
    'brand',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES brands (id)',
    ),
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _costPriceMeta = const VerificationMeta(
    'costPrice',
  );
  @override
  late final GeneratedColumn<double> costPrice = GeneratedColumn<double>(
    'cost_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellingPriceMeta = const VerificationMeta(
    'sellingPrice',
  );
  @override
  late final GeneratedColumn<double> sellingPrice = GeneratedColumn<double>(
    'selling_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    brand,
    model,
    category,
    costPrice,
    sellingPrice,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('cost_price')) {
      context.handle(
        _costPriceMeta,
        costPrice.isAcceptableOrUnknown(data['cost_price']!, _costPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_costPriceMeta);
    }
    if (data.containsKey('selling_price')) {
      context.handle(
        _sellingPriceMeta,
        sellingPrice.isAcceptableOrUnknown(
          data['selling_price']!,
          _sellingPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellingPriceMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brand'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category'],
      )!,
      costPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_price'],
      )!,
      sellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}selling_price'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final int brand;
  final String model;
  final int category;
  final double costPrice;
  final double sellingPrice;
  final int isActive;
  final DateTime createdAt;
  const Product({
    required this.id,
    required this.brand,
    required this.model,
    required this.category,
    required this.costPrice,
    required this.sellingPrice,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['brand'] = Variable<int>(brand);
    map['model'] = Variable<String>(model);
    map['category'] = Variable<int>(category);
    map['cost_price'] = Variable<double>(costPrice);
    map['selling_price'] = Variable<double>(sellingPrice);
    map['is_active'] = Variable<int>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      brand: Value(brand),
      model: Value(model),
      category: Value(category),
      costPrice: Value(costPrice),
      sellingPrice: Value(sellingPrice),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      brand: serializer.fromJson<int>(json['brand']),
      model: serializer.fromJson<String>(json['model']),
      category: serializer.fromJson<int>(json['category']),
      costPrice: serializer.fromJson<double>(json['costPrice']),
      sellingPrice: serializer.fromJson<double>(json['sellingPrice']),
      isActive: serializer.fromJson<int>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'brand': serializer.toJson<int>(brand),
      'model': serializer.toJson<String>(model),
      'category': serializer.toJson<int>(category),
      'costPrice': serializer.toJson<double>(costPrice),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'isActive': serializer.toJson<int>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Product copyWith({
    int? id,
    int? brand,
    String? model,
    int? category,
    double? costPrice,
    double? sellingPrice,
    int? isActive,
    DateTime? createdAt,
  }) => Product(
    id: id ?? this.id,
    brand: brand ?? this.brand,
    model: model ?? this.model,
    category: category ?? this.category,
    costPrice: costPrice ?? this.costPrice,
    sellingPrice: sellingPrice ?? this.sellingPrice,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      category: data.category.present ? data.category.value : this.category,
      costPrice: data.costPrice.present ? data.costPrice.value : this.costPrice,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('category: $category, ')
          ..write('costPrice: $costPrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    brand,
    model,
    category,
    costPrice,
    sellingPrice,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.category == this.category &&
          other.costPrice == this.costPrice &&
          other.sellingPrice == this.sellingPrice &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<int> brand;
  final Value<String> model;
  final Value<int> category;
  final Value<double> costPrice;
  final Value<double> sellingPrice;
  final Value<int> isActive;
  final Value<DateTime> createdAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.category = const Value.absent(),
    this.costPrice = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required int brand,
    required String model,
    required int category,
    required double costPrice,
    required double sellingPrice,
    required int isActive,
    this.createdAt = const Value.absent(),
  }) : brand = Value(brand),
       model = Value(model),
       category = Value(category),
       costPrice = Value(costPrice),
       sellingPrice = Value(sellingPrice),
       isActive = Value(isActive);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<int>? brand,
    Expression<String>? model,
    Expression<int>? category,
    Expression<double>? costPrice,
    Expression<double>? sellingPrice,
    Expression<int>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (category != null) 'category': category,
      if (costPrice != null) 'cost_price': costPrice,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<int>? brand,
    Value<String>? model,
    Value<int>? category,
    Value<double>? costPrice,
    Value<double>? sellingPrice,
    Value<int>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      category: category ?? this.category,
      costPrice: costPrice ?? this.costPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (brand.present) {
      map['brand'] = Variable<int>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (costPrice.present) {
      map['cost_price'] = Variable<double>(costPrice.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<double>(sellingPrice.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('category: $category, ')
          ..write('costPrice: $costPrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AvailableColorsTable extends AvailableColors
    with TableInfo<$AvailableColorsTable, AvailableColor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AvailableColorsTable(this.attachedDatabase, [this._alias]);
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
  List<GeneratedColumn> get $columns => [id, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'available_colors';
  @override
  VerificationContext validateIntegrity(
    Insertable<AvailableColor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AvailableColor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AvailableColor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AvailableColorsTable createAlias(String alias) {
    return $AvailableColorsTable(attachedDatabase, alias);
  }
}

class AvailableColor extends DataClass implements Insertable<AvailableColor> {
  final int id;
  final String value;
  const AvailableColor({required this.id, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['value'] = Variable<String>(value);
    return map;
  }

  AvailableColorsCompanion toCompanion(bool nullToAbsent) {
    return AvailableColorsCompanion(id: Value(id), value: Value(value));
  }

  factory AvailableColor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AvailableColor(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<String>(value),
    };
  }

  AvailableColor copyWith({int? id, String? value}) =>
      AvailableColor(id: id ?? this.id, value: value ?? this.value);
  AvailableColor copyWithCompanion(AvailableColorsCompanion data) {
    return AvailableColor(
      id: data.id.present ? data.id.value : this.id,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AvailableColor(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AvailableColor &&
          other.id == this.id &&
          other.value == this.value);
}

class AvailableColorsCompanion extends UpdateCompanion<AvailableColor> {
  final Value<int> id;
  final Value<String> value;
  const AvailableColorsCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
  });
  AvailableColorsCompanion.insert({
    this.id = const Value.absent(),
    required String value,
  }) : value = Value(value);
  static Insertable<AvailableColor> custom({
    Expression<int>? id,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
    });
  }

  AvailableColorsCompanion copyWith({Value<int>? id, Value<String>? value}) {
    return AvailableColorsCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AvailableColorsCompanion(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $VariantsTable extends Variants with TableInfo<$VariantsTable, Variant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VariantsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES available_colors (id)',
    ),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [id, productId, color, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'variants';
  @override
  VerificationContext validateIntegrity(
    Insertable<Variant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Variant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Variant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $VariantsTable createAlias(String alias) {
    return $VariantsTable(attachedDatabase, alias);
  }
}

class Variant extends DataClass implements Insertable<Variant> {
  final int id;
  final int productId;
  final int color;
  final int isActive;
  const Variant({
    required this.id,
    required this.productId,
    required this.color,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['color'] = Variable<int>(color);
    map['is_active'] = Variable<int>(isActive);
    return map;
  }

  VariantsCompanion toCompanion(bool nullToAbsent) {
    return VariantsCompanion(
      id: Value(id),
      productId: Value(productId),
      color: Value(color),
      isActive: Value(isActive),
    );
  }

  factory Variant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Variant(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      color: serializer.fromJson<int>(json['color']),
      isActive: serializer.fromJson<int>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'color': serializer.toJson<int>(color),
      'isActive': serializer.toJson<int>(isActive),
    };
  }

  Variant copyWith({int? id, int? productId, int? color, int? isActive}) =>
      Variant(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        color: color ?? this.color,
        isActive: isActive ?? this.isActive,
      );
  Variant copyWithCompanion(VariantsCompanion data) {
    return Variant(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      color: data.color.present ? data.color.value : this.color,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Variant(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('color: $color, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, color, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Variant &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.color == this.color &&
          other.isActive == this.isActive);
}

class VariantsCompanion extends UpdateCompanion<Variant> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> color;
  final Value<int> isActive;
  const VariantsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.color = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  VariantsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int color,
    this.isActive = const Value.absent(),
  }) : productId = Value(productId),
       color = Value(color);
  static Insertable<Variant> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? color,
    Expression<int>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (color != null) 'color': color,
      if (isActive != null) 'is_active': isActive,
    });
  }

  VariantsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int>? color,
    Value<int>? isActive,
  }) {
    return VariantsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      color: color ?? this.color,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VariantsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('color: $color, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $AvailableSizesTable extends AvailableSizes
    with TableInfo<$AvailableSizesTable, AvailableSize> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AvailableSizesTable(this.attachedDatabase, [this._alias]);
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
  List<GeneratedColumn> get $columns => [id, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'available_sizes';
  @override
  VerificationContext validateIntegrity(
    Insertable<AvailableSize> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AvailableSize map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AvailableSize(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AvailableSizesTable createAlias(String alias) {
    return $AvailableSizesTable(attachedDatabase, alias);
  }
}

class AvailableSize extends DataClass implements Insertable<AvailableSize> {
  final int id;
  final String value;
  const AvailableSize({required this.id, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['value'] = Variable<String>(value);
    return map;
  }

  AvailableSizesCompanion toCompanion(bool nullToAbsent) {
    return AvailableSizesCompanion(id: Value(id), value: Value(value));
  }

  factory AvailableSize.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AvailableSize(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<String>(value),
    };
  }

  AvailableSize copyWith({int? id, String? value}) =>
      AvailableSize(id: id ?? this.id, value: value ?? this.value);
  AvailableSize copyWithCompanion(AvailableSizesCompanion data) {
    return AvailableSize(
      id: data.id.present ? data.id.value : this.id,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AvailableSize(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AvailableSize &&
          other.id == this.id &&
          other.value == this.value);
}

class AvailableSizesCompanion extends UpdateCompanion<AvailableSize> {
  final Value<int> id;
  final Value<String> value;
  const AvailableSizesCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
  });
  AvailableSizesCompanion.insert({
    this.id = const Value.absent(),
    required String value,
  }) : value = Value(value);
  static Insertable<AvailableSize> custom({
    Expression<int>? id,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
    });
  }

  AvailableSizesCompanion copyWith({Value<int>? id, Value<String>? value}) {
    return AvailableSizesCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AvailableSizesCompanion(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $SizesTable extends Sizes with TableInfo<$SizesTable, Size> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SizesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<int> variantId = GeneratedColumn<int>(
    'variant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES variants (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES variants (product_id)',
    ),
  );
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
    'stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeValuesMeta = const VerificationMeta(
    'sizeValues',
  );
  @override
  late final GeneratedColumn<int> sizeValues = GeneratedColumn<int>(
    'size_values',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES available_sizes (id)',
    ),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    variantId,
    productId,
    stock,
    sizeValues,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sizes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Size> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('stock')) {
      context.handle(
        _stockMeta,
        stock.isAcceptableOrUnknown(data['stock']!, _stockMeta),
      );
    } else if (isInserting) {
      context.missing(_stockMeta);
    }
    if (data.containsKey('size_values')) {
      context.handle(
        _sizeValuesMeta,
        sizeValues.isAcceptableOrUnknown(data['size_values']!, _sizeValuesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeValuesMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Size map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Size(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}variant_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      stock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock'],
      )!,
      sizeValues: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_values'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $SizesTable createAlias(String alias) {
    return $SizesTable(attachedDatabase, alias);
  }
}

class Size extends DataClass implements Insertable<Size> {
  final int id;
  final int variantId;
  final int productId;
  final int stock;
  final int sizeValues;
  final int isActive;
  const Size({
    required this.id,
    required this.variantId,
    required this.productId,
    required this.stock,
    required this.sizeValues,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['variant_id'] = Variable<int>(variantId);
    map['product_id'] = Variable<int>(productId);
    map['stock'] = Variable<int>(stock);
    map['size_values'] = Variable<int>(sizeValues);
    map['is_active'] = Variable<int>(isActive);
    return map;
  }

  SizesCompanion toCompanion(bool nullToAbsent) {
    return SizesCompanion(
      id: Value(id),
      variantId: Value(variantId),
      productId: Value(productId),
      stock: Value(stock),
      sizeValues: Value(sizeValues),
      isActive: Value(isActive),
    );
  }

  factory Size.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Size(
      id: serializer.fromJson<int>(json['id']),
      variantId: serializer.fromJson<int>(json['variantId']),
      productId: serializer.fromJson<int>(json['productId']),
      stock: serializer.fromJson<int>(json['stock']),
      sizeValues: serializer.fromJson<int>(json['sizeValues']),
      isActive: serializer.fromJson<int>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'variantId': serializer.toJson<int>(variantId),
      'productId': serializer.toJson<int>(productId),
      'stock': serializer.toJson<int>(stock),
      'sizeValues': serializer.toJson<int>(sizeValues),
      'isActive': serializer.toJson<int>(isActive),
    };
  }

  Size copyWith({
    int? id,
    int? variantId,
    int? productId,
    int? stock,
    int? sizeValues,
    int? isActive,
  }) => Size(
    id: id ?? this.id,
    variantId: variantId ?? this.variantId,
    productId: productId ?? this.productId,
    stock: stock ?? this.stock,
    sizeValues: sizeValues ?? this.sizeValues,
    isActive: isActive ?? this.isActive,
  );
  Size copyWithCompanion(SizesCompanion data) {
    return Size(
      id: data.id.present ? data.id.value : this.id,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      productId: data.productId.present ? data.productId.value : this.productId,
      stock: data.stock.present ? data.stock.value : this.stock,
      sizeValues: data.sizeValues.present
          ? data.sizeValues.value
          : this.sizeValues,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Size(')
          ..write('id: $id, ')
          ..write('variantId: $variantId, ')
          ..write('productId: $productId, ')
          ..write('stock: $stock, ')
          ..write('sizeValues: $sizeValues, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, variantId, productId, stock, sizeValues, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Size &&
          other.id == this.id &&
          other.variantId == this.variantId &&
          other.productId == this.productId &&
          other.stock == this.stock &&
          other.sizeValues == this.sizeValues &&
          other.isActive == this.isActive);
}

class SizesCompanion extends UpdateCompanion<Size> {
  final Value<int> id;
  final Value<int> variantId;
  final Value<int> productId;
  final Value<int> stock;
  final Value<int> sizeValues;
  final Value<int> isActive;
  const SizesCompanion({
    this.id = const Value.absent(),
    this.variantId = const Value.absent(),
    this.productId = const Value.absent(),
    this.stock = const Value.absent(),
    this.sizeValues = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  SizesCompanion.insert({
    this.id = const Value.absent(),
    required int variantId,
    required int productId,
    required int stock,
    required int sizeValues,
    this.isActive = const Value.absent(),
  }) : variantId = Value(variantId),
       productId = Value(productId),
       stock = Value(stock),
       sizeValues = Value(sizeValues);
  static Insertable<Size> custom({
    Expression<int>? id,
    Expression<int>? variantId,
    Expression<int>? productId,
    Expression<int>? stock,
    Expression<int>? sizeValues,
    Expression<int>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (variantId != null) 'variant_id': variantId,
      if (productId != null) 'product_id': productId,
      if (stock != null) 'stock': stock,
      if (sizeValues != null) 'size_values': sizeValues,
      if (isActive != null) 'is_active': isActive,
    });
  }

  SizesCompanion copyWith({
    Value<int>? id,
    Value<int>? variantId,
    Value<int>? productId,
    Value<int>? stock,
    Value<int>? sizeValues,
    Value<int>? isActive,
  }) {
    return SizesCompanion(
      id: id ?? this.id,
      variantId: variantId ?? this.variantId,
      productId: productId ?? this.productId,
      stock: stock ?? this.stock,
      sizeValues: sizeValues ?? this.sizeValues,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<int>(variantId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (sizeValues.present) {
      map['size_values'] = Variable<int>(sizeValues.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SizesCompanion(')
          ..write('id: $id, ')
          ..write('variantId: $variantId, ')
          ..write('productId: $productId, ')
          ..write('stock: $stock, ')
          ..write('sizeValues: $sizeValues, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, total, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final int id;
  final double total;
  final DateTime createdAt;
  const Sale({required this.id, required this.total, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total'] = Variable<double>(total);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      total: Value(total),
      createdAt: Value(createdAt),
    );
  }

  factory Sale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<int>(json['id']),
      total: serializer.fromJson<double>(json['total']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'total': serializer.toJson<double>(total),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Sale copyWith({int? id, double? total, DateTime? createdAt}) => Sale(
    id: id ?? this.id,
    total: total ?? this.total,
    createdAt: createdAt ?? this.createdAt,
  );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      total: data.total.present ? data.total.value : this.total,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, total, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.total == this.total &&
          other.createdAt == this.createdAt);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<int> id;
  final Value<double> total;
  final Value<DateTime> createdAt;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.total = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SalesCompanion.insert({
    this.id = const Value.absent(),
    required double total,
    this.createdAt = const Value.absent(),
  }) : total = Value(total);
  static Insertable<Sale> custom({
    Expression<int>? id,
    Expression<double>? total,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (total != null) 'total': total,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SalesCompanion copyWith({
    Value<int>? id,
    Value<double>? total,
    Value<DateTime>? createdAt,
  }) {
    return SalesCompanion(
      id: id ?? this.id,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SaleItemsTable extends SaleItems
    with TableInfo<$SaleItemsTable, SaleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<int> saleId = GeneratedColumn<int>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sales (id)',
    ),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<int> brand = GeneratedColumn<int>(
    'brand',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES brands (id)',
    ),
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES available_sizes (id)',
    ),
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES available_colors (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    saleId,
    price,
    quantity,
    brand,
    model,
    size,
    color,
    productId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sale_id'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brand'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SaleItemsTable createAlias(String alias) {
    return $SaleItemsTable(attachedDatabase, alias);
  }
}

class SaleItem extends DataClass implements Insertable<SaleItem> {
  final int id;
  final int saleId;
  final double price;
  final int quantity;
  final int brand;
  final String model;
  final int size;
  final int color;
  final int productId;
  final DateTime createdAt;
  const SaleItem({
    required this.id,
    required this.saleId,
    required this.price,
    required this.quantity,
    required this.brand,
    required this.model,
    required this.size,
    required this.color,
    required this.productId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sale_id'] = Variable<int>(saleId);
    map['price'] = Variable<double>(price);
    map['quantity'] = Variable<int>(quantity);
    map['brand'] = Variable<int>(brand);
    map['model'] = Variable<String>(model);
    map['size'] = Variable<int>(size);
    map['color'] = Variable<int>(color);
    map['product_id'] = Variable<int>(productId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SaleItemsCompanion toCompanion(bool nullToAbsent) {
    return SaleItemsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      price: Value(price),
      quantity: Value(quantity),
      brand: Value(brand),
      model: Value(model),
      size: Value(size),
      color: Value(color),
      productId: Value(productId),
      createdAt: Value(createdAt),
    );
  }

  factory SaleItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleItem(
      id: serializer.fromJson<int>(json['id']),
      saleId: serializer.fromJson<int>(json['saleId']),
      price: serializer.fromJson<double>(json['price']),
      quantity: serializer.fromJson<int>(json['quantity']),
      brand: serializer.fromJson<int>(json['brand']),
      model: serializer.fromJson<String>(json['model']),
      size: serializer.fromJson<int>(json['size']),
      color: serializer.fromJson<int>(json['color']),
      productId: serializer.fromJson<int>(json['productId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'saleId': serializer.toJson<int>(saleId),
      'price': serializer.toJson<double>(price),
      'quantity': serializer.toJson<int>(quantity),
      'brand': serializer.toJson<int>(brand),
      'model': serializer.toJson<String>(model),
      'size': serializer.toJson<int>(size),
      'color': serializer.toJson<int>(color),
      'productId': serializer.toJson<int>(productId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SaleItem copyWith({
    int? id,
    int? saleId,
    double? price,
    int? quantity,
    int? brand,
    String? model,
    int? size,
    int? color,
    int? productId,
    DateTime? createdAt,
  }) => SaleItem(
    id: id ?? this.id,
    saleId: saleId ?? this.saleId,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
    brand: brand ?? this.brand,
    model: model ?? this.model,
    size: size ?? this.size,
    color: color ?? this.color,
    productId: productId ?? this.productId,
    createdAt: createdAt ?? this.createdAt,
  );
  SaleItem copyWithCompanion(SaleItemsCompanion data) {
    return SaleItem(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      price: data.price.present ? data.price.value : this.price,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      size: data.size.present ? data.size.value : this.size,
      color: data.color.present ? data.color.value : this.color,
      productId: data.productId.present ? data.productId.value : this.productId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleItem(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('price: $price, ')
          ..write('quantity: $quantity, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('size: $size, ')
          ..write('color: $color, ')
          ..write('productId: $productId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    saleId,
    price,
    quantity,
    brand,
    model,
    size,
    color,
    productId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleItem &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.price == this.price &&
          other.quantity == this.quantity &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.size == this.size &&
          other.color == this.color &&
          other.productId == this.productId &&
          other.createdAt == this.createdAt);
}

class SaleItemsCompanion extends UpdateCompanion<SaleItem> {
  final Value<int> id;
  final Value<int> saleId;
  final Value<double> price;
  final Value<int> quantity;
  final Value<int> brand;
  final Value<String> model;
  final Value<int> size;
  final Value<int> color;
  final Value<int> productId;
  final Value<DateTime> createdAt;
  const SaleItemsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.price = const Value.absent(),
    this.quantity = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.size = const Value.absent(),
    this.color = const Value.absent(),
    this.productId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SaleItemsCompanion.insert({
    this.id = const Value.absent(),
    required int saleId,
    required double price,
    required int quantity,
    required int brand,
    required String model,
    required int size,
    required int color,
    required int productId,
    this.createdAt = const Value.absent(),
  }) : saleId = Value(saleId),
       price = Value(price),
       quantity = Value(quantity),
       brand = Value(brand),
       model = Value(model),
       size = Value(size),
       color = Value(color),
       productId = Value(productId);
  static Insertable<SaleItem> custom({
    Expression<int>? id,
    Expression<int>? saleId,
    Expression<double>? price,
    Expression<int>? quantity,
    Expression<int>? brand,
    Expression<String>? model,
    Expression<int>? size,
    Expression<int>? color,
    Expression<int>? productId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (price != null) 'price': price,
      if (quantity != null) 'quantity': quantity,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (size != null) 'size': size,
      if (color != null) 'color': color,
      if (productId != null) 'product_id': productId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SaleItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? saleId,
    Value<double>? price,
    Value<int>? quantity,
    Value<int>? brand,
    Value<String>? model,
    Value<int>? size,
    Value<int>? color,
    Value<int>? productId,
    Value<DateTime>? createdAt,
  }) {
    return SaleItemsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      size: size ?? this.size,
      color: color ?? this.color,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<int>(saleId.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (brand.present) {
      map['brand'] = Variable<int>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('price: $price, ')
          ..write('quantity: $quantity, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('size: $size, ')
          ..write('color: $color, ')
          ..write('productId: $productId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _relatedIdMeta = const VerificationMeta(
    'relatedId',
  );
  @override
  late final GeneratedColumn<int> relatedId = GeneratedColumn<int>(
    'related_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, note, relatedId, total];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('related_id')) {
      context.handle(
        _relatedIdMeta,
        relatedId.isAcceptableOrUnknown(data['related_id']!, _relatedIdMeta),
      );
    } else if (isInserting) {
      context.missing(_relatedIdMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      relatedId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}related_id'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final DateTime createdAt;
  final String? note;
  final int relatedId;
  final double total;
  const Expense({
    required this.id,
    required this.createdAt,
    this.note,
    required this.relatedId,
    required this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['related_id'] = Variable<int>(relatedId);
    map['total'] = Variable<double>(total);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      relatedId: Value(relatedId),
      total: Value(total),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      note: serializer.fromJson<String?>(json['note']),
      relatedId: serializer.fromJson<int>(json['relatedId']),
      total: serializer.fromJson<double>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'note': serializer.toJson<String?>(note),
      'relatedId': serializer.toJson<int>(relatedId),
      'total': serializer.toJson<double>(total),
    };
  }

  Expense copyWith({
    int? id,
    DateTime? createdAt,
    Value<String?> note = const Value.absent(),
    int? relatedId,
    double? total,
  }) => Expense(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    note: note.present ? note.value : this.note,
    relatedId: relatedId ?? this.relatedId,
    total: total ?? this.total,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      note: data.note.present ? data.note.value : this.note,
      relatedId: data.relatedId.present ? data.relatedId.value : this.relatedId,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('note: $note, ')
          ..write('relatedId: $relatedId, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, note, relatedId, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.note == this.note &&
          other.relatedId == this.relatedId &&
          other.total == this.total);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String?> note;
  final Value<int> relatedId;
  final Value<double> total;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.note = const Value.absent(),
    this.relatedId = const Value.absent(),
    this.total = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.note = const Value.absent(),
    required int relatedId,
    required double total,
  }) : relatedId = Value(relatedId),
       total = Value(total);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? note,
    Expression<int>? relatedId,
    Expression<double>? total,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (note != null) 'note': note,
      if (relatedId != null) 'related_id': relatedId,
      if (total != null) 'total': total,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<String?>? note,
    Value<int>? relatedId,
    Value<double>? total,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      note: note ?? this.note,
      relatedId: relatedId ?? this.relatedId,
      total: total ?? this.total,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (relatedId.present) {
      map['related_id'] = Variable<int>(relatedId.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('note: $note, ')
          ..write('relatedId: $relatedId, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }
}

class $ExpensesItemsTable extends ExpensesItems
    with TableInfo<$ExpensesItemsTable, ExpenseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _expenseIdMeta = const VerificationMeta(
    'expenseId',
  );
  @override
  late final GeneratedColumn<int> expenseId = GeneratedColumn<int>(
    'expense_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES expenses (id)',
    ),
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<int> variantId = GeneratedColumn<int>(
    'variant_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES variants (id)',
    ),
  );
  static const VerificationMeta _sizeIdMeta = const VerificationMeta('sizeId');
  @override
  late final GeneratedColumn<int> sizeId = GeneratedColumn<int>(
    'size_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sizes (id)',
    ),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    expenseId,
    variantId,
    sizeId,
    price,
    quantity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('expense_id')) {
      context.handle(
        _expenseIdMeta,
        expenseId.isAcceptableOrUnknown(data['expense_id']!, _expenseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_expenseIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('size_id')) {
      context.handle(
        _sizeIdMeta,
        sizeId.isAcceptableOrUnknown(data['size_id']!, _sizeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeIdMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      expenseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expense_id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}variant_id'],
      )!,
      sizeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_id'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
    );
  }

  @override
  $ExpensesItemsTable createAlias(String alias) {
    return $ExpensesItemsTable(attachedDatabase, alias);
  }
}

class ExpenseItem extends DataClass implements Insertable<ExpenseItem> {
  final int id;
  final int expenseId;
  final int variantId;
  final int sizeId;
  final double price;
  final int quantity;
  const ExpenseItem({
    required this.id,
    required this.expenseId,
    required this.variantId,
    required this.sizeId,
    required this.price,
    required this.quantity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['expense_id'] = Variable<int>(expenseId);
    map['variant_id'] = Variable<int>(variantId);
    map['size_id'] = Variable<int>(sizeId);
    map['price'] = Variable<double>(price);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  ExpensesItemsCompanion toCompanion(bool nullToAbsent) {
    return ExpensesItemsCompanion(
      id: Value(id),
      expenseId: Value(expenseId),
      variantId: Value(variantId),
      sizeId: Value(sizeId),
      price: Value(price),
      quantity: Value(quantity),
    );
  }

  factory ExpenseItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseItem(
      id: serializer.fromJson<int>(json['id']),
      expenseId: serializer.fromJson<int>(json['expenseId']),
      variantId: serializer.fromJson<int>(json['variantId']),
      sizeId: serializer.fromJson<int>(json['sizeId']),
      price: serializer.fromJson<double>(json['price']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'expenseId': serializer.toJson<int>(expenseId),
      'variantId': serializer.toJson<int>(variantId),
      'sizeId': serializer.toJson<int>(sizeId),
      'price': serializer.toJson<double>(price),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  ExpenseItem copyWith({
    int? id,
    int? expenseId,
    int? variantId,
    int? sizeId,
    double? price,
    int? quantity,
  }) => ExpenseItem(
    id: id ?? this.id,
    expenseId: expenseId ?? this.expenseId,
    variantId: variantId ?? this.variantId,
    sizeId: sizeId ?? this.sizeId,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
  );
  ExpenseItem copyWithCompanion(ExpensesItemsCompanion data) {
    return ExpenseItem(
      id: data.id.present ? data.id.value : this.id,
      expenseId: data.expenseId.present ? data.expenseId.value : this.expenseId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      sizeId: data.sizeId.present ? data.sizeId.value : this.sizeId,
      price: data.price.present ? data.price.value : this.price,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseItem(')
          ..write('id: $id, ')
          ..write('expenseId: $expenseId, ')
          ..write('variantId: $variantId, ')
          ..write('sizeId: $sizeId, ')
          ..write('price: $price, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, expenseId, variantId, sizeId, price, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseItem &&
          other.id == this.id &&
          other.expenseId == this.expenseId &&
          other.variantId == this.variantId &&
          other.sizeId == this.sizeId &&
          other.price == this.price &&
          other.quantity == this.quantity);
}

class ExpensesItemsCompanion extends UpdateCompanion<ExpenseItem> {
  final Value<int> id;
  final Value<int> expenseId;
  final Value<int> variantId;
  final Value<int> sizeId;
  final Value<double> price;
  final Value<int> quantity;
  const ExpensesItemsCompanion({
    this.id = const Value.absent(),
    this.expenseId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.sizeId = const Value.absent(),
    this.price = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  ExpensesItemsCompanion.insert({
    this.id = const Value.absent(),
    required int expenseId,
    required int variantId,
    required int sizeId,
    required double price,
    required int quantity,
  }) : expenseId = Value(expenseId),
       variantId = Value(variantId),
       sizeId = Value(sizeId),
       price = Value(price),
       quantity = Value(quantity);
  static Insertable<ExpenseItem> custom({
    Expression<int>? id,
    Expression<int>? expenseId,
    Expression<int>? variantId,
    Expression<int>? sizeId,
    Expression<double>? price,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (expenseId != null) 'expense_id': expenseId,
      if (variantId != null) 'variant_id': variantId,
      if (sizeId != null) 'size_id': sizeId,
      if (price != null) 'price': price,
      if (quantity != null) 'quantity': quantity,
    });
  }

  ExpensesItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? expenseId,
    Value<int>? variantId,
    Value<int>? sizeId,
    Value<double>? price,
    Value<int>? quantity,
  }) {
    return ExpensesItemsCompanion(
      id: id ?? this.id,
      expenseId: expenseId ?? this.expenseId,
      variantId: variantId ?? this.variantId,
      sizeId: sizeId ?? this.sizeId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (expenseId.present) {
      map['expense_id'] = Variable<int>(expenseId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<int>(variantId.value);
    }
    if (sizeId.present) {
      map['size_id'] = Variable<int>(sizeId.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesItemsCompanion(')
          ..write('id: $id, ')
          ..write('expenseId: $expenseId, ')
          ..write('variantId: $variantId, ')
          ..write('sizeId: $sizeId, ')
          ..write('price: $price, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

class $CachesTable extends Caches with TableInfo<$CachesTable, Cache> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<int> theme = GeneratedColumn<int>(
    'theme',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  static const VerificationMeta _passawordMeta = const VerificationMeta(
    'passaword',
  );
  @override
  late final GeneratedColumn<int> passaword = GeneratedColumn<int>(
    'passaword',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(102025),
  );
  @override
  List<GeneratedColumn> get $columns => [id, theme, passaword];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'caches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Cache> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme')) {
      context.handle(
        _themeMeta,
        theme.isAcceptableOrUnknown(data['theme']!, _themeMeta),
      );
    }
    if (data.containsKey('passaword')) {
      context.handle(
        _passawordMeta,
        passaword.isAcceptableOrUnknown(data['passaword']!, _passawordMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cache map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cache(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      theme: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}theme'],
      )!,
      passaword: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}passaword'],
      )!,
    );
  }

  @override
  $CachesTable createAlias(String alias) {
    return $CachesTable(attachedDatabase, alias);
  }
}

class Cache extends DataClass implements Insertable<Cache> {
  final int id;
  final int theme;
  final int passaword;
  const Cache({required this.id, required this.theme, required this.passaword});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['theme'] = Variable<int>(theme);
    map['passaword'] = Variable<int>(passaword);
    return map;
  }

  CachesCompanion toCompanion(bool nullToAbsent) {
    return CachesCompanion(
      id: Value(id),
      theme: Value(theme),
      passaword: Value(passaword),
    );
  }

  factory Cache.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cache(
      id: serializer.fromJson<int>(json['id']),
      theme: serializer.fromJson<int>(json['theme']),
      passaword: serializer.fromJson<int>(json['passaword']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'theme': serializer.toJson<int>(theme),
      'passaword': serializer.toJson<int>(passaword),
    };
  }

  Cache copyWith({int? id, int? theme, int? passaword}) => Cache(
    id: id ?? this.id,
    theme: theme ?? this.theme,
    passaword: passaword ?? this.passaword,
  );
  Cache copyWithCompanion(CachesCompanion data) {
    return Cache(
      id: data.id.present ? data.id.value : this.id,
      theme: data.theme.present ? data.theme.value : this.theme,
      passaword: data.passaword.present ? data.passaword.value : this.passaword,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cache(')
          ..write('id: $id, ')
          ..write('theme: $theme, ')
          ..write('passaword: $passaword')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, theme, passaword);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cache &&
          other.id == this.id &&
          other.theme == this.theme &&
          other.passaword == this.passaword);
}

class CachesCompanion extends UpdateCompanion<Cache> {
  final Value<int> id;
  final Value<int> theme;
  final Value<int> passaword;
  const CachesCompanion({
    this.id = const Value.absent(),
    this.theme = const Value.absent(),
    this.passaword = const Value.absent(),
  });
  CachesCompanion.insert({
    this.id = const Value.absent(),
    this.theme = const Value.absent(),
    this.passaword = const Value.absent(),
  });
  static Insertable<Cache> custom({
    Expression<int>? id,
    Expression<int>? theme,
    Expression<int>? passaword,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (theme != null) 'theme': theme,
      if (passaword != null) 'passaword': passaword,
    });
  }

  CachesCompanion copyWith({
    Value<int>? id,
    Value<int>? theme,
    Value<int>? passaword,
  }) {
    return CachesCompanion(
      id: id ?? this.id,
      theme: theme ?? this.theme,
      passaword: passaword ?? this.passaword,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (theme.present) {
      map['theme'] = Variable<int>(theme.value);
    }
    if (passaword.present) {
      map['passaword'] = Variable<int>(passaword.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachesCompanion(')
          ..write('id: $id, ')
          ..write('theme: $theme, ')
          ..write('passaword: $passaword')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BrandsTable brands = $BrandsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $AvailableColorsTable availableColors = $AvailableColorsTable(
    this,
  );
  late final $VariantsTable variants = $VariantsTable(this);
  late final $AvailableSizesTable availableSizes = $AvailableSizesTable(this);
  late final $SizesTable sizes = $SizesTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $SaleItemsTable saleItems = $SaleItemsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $ExpensesItemsTable expensesItems = $ExpensesItemsTable(this);
  late final $CachesTable caches = $CachesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    brands,
    categories,
    products,
    availableColors,
    variants,
    availableSizes,
    sizes,
    sales,
    saleItems,
    expenses,
    expensesItems,
    caches,
  ];
}

typedef $$BrandsTableCreateCompanionBuilder =
    BrandsCompanion Function({Value<int> id, required String value});
typedef $$BrandsTableUpdateCompanionBuilder =
    BrandsCompanion Function({Value<int> id, Value<String> value});

final class $$BrandsTableReferences
    extends BaseReferences<_$AppDatabase, $BrandsTable, Brand> {
  $$BrandsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductsTable, List<Product>> _productsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: $_aliasNameGenerator(db.brands.id, db.products.brand),
  );

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.brand.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SaleItemsTable, List<SaleItem>>
  _saleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleItems,
    aliasName: $_aliasNameGenerator(db.brands.id, db.saleItems.brand),
  );

  $$SaleItemsTableProcessedTableManager get saleItemsRefs {
    final manager = $$SaleItemsTableTableManager(
      $_db,
      $_db.saleItems,
    ).filter((f) => f.brand.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BrandsTableFilterComposer
    extends Composer<_$AppDatabase, $BrandsTable> {
  $$BrandsTableFilterComposer({
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

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productsRefs(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.brand,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> saleItemsRefs(
    Expression<bool> Function($$SaleItemsTableFilterComposer f) f,
  ) {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.brand,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BrandsTableOrderingComposer
    extends Composer<_$AppDatabase, $BrandsTable> {
  $$BrandsTableOrderingComposer({
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

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BrandsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BrandsTable> {
  $$BrandsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  Expression<T> productsRefs<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.brand,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> saleItemsRefs<T extends Object>(
    Expression<T> Function($$SaleItemsTableAnnotationComposer a) f,
  ) {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.brand,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BrandsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BrandsTable,
          Brand,
          $$BrandsTableFilterComposer,
          $$BrandsTableOrderingComposer,
          $$BrandsTableAnnotationComposer,
          $$BrandsTableCreateCompanionBuilder,
          $$BrandsTableUpdateCompanionBuilder,
          (Brand, $$BrandsTableReferences),
          Brand,
          PrefetchHooks Function({bool productsRefs, bool saleItemsRefs})
        > {
  $$BrandsTableTableManager(_$AppDatabase db, $BrandsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrandsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BrandsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BrandsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> value = const Value.absent(),
              }) => BrandsCompanion(id: id, value: value),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String value}) =>
                  BrandsCompanion.insert(id: id, value: value),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BrandsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({productsRefs = false, saleItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (productsRefs) db.products,
                    if (saleItemsRefs) db.saleItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (productsRefs)
                        await $_getPrefetchedData<Brand, $BrandsTable, Product>(
                          currentTable: table,
                          referencedTable: $$BrandsTableReferences
                              ._productsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BrandsTableReferences(
                                db,
                                table,
                                p0,
                              ).productsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.brand == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (saleItemsRefs)
                        await $_getPrefetchedData<
                          Brand,
                          $BrandsTable,
                          SaleItem
                        >(
                          currentTable: table,
                          referencedTable: $$BrandsTableReferences
                              ._saleItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BrandsTableReferences(
                                db,
                                table,
                                p0,
                              ).saleItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.brand == item.id,
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

typedef $$BrandsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BrandsTable,
      Brand,
      $$BrandsTableFilterComposer,
      $$BrandsTableOrderingComposer,
      $$BrandsTableAnnotationComposer,
      $$BrandsTableCreateCompanionBuilder,
      $$BrandsTableUpdateCompanionBuilder,
      (Brand, $$BrandsTableReferences),
      Brand,
      PrefetchHooks Function({bool productsRefs, bool saleItemsRefs})
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({Value<int> id, required String value});
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({Value<int> id, Value<String> value});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductsTable, List<Product>> _productsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: $_aliasNameGenerator(db.categories.id, db.products.category),
  );

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.category.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
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

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productsRefs(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.category,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  Expression<T> productsRefs<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.category,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool productsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> value = const Value.absent(),
              }) => CategoriesCompanion(id: id, value: value),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String value}) =>
                  CategoriesCompanion.insert(id: id, value: value),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productsRefs) db.products],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productsRefs)
                    await $_getPrefetchedData<
                      Category,
                      $CategoriesTable,
                      Product
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._productsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).productsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.category == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool productsRefs})
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required int brand,
      required String model,
      required int category,
      required double costPrice,
      required double sellingPrice,
      required int isActive,
      Value<DateTime> createdAt,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<int> brand,
      Value<String> model,
      Value<int> category,
      Value<double> costPrice,
      Value<double> sellingPrice,
      Value<int> isActive,
      Value<DateTime> createdAt,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BrandsTable _brandTable(_$AppDatabase db) => db.brands.createAlias(
    $_aliasNameGenerator(db.products.brand, db.brands.id),
  );

  $$BrandsTableProcessedTableManager get brand {
    final $_column = $_itemColumn<int>('brand')!;

    final manager = $$BrandsTableTableManager(
      $_db,
      $_db.brands,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_brandTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryTable(_$AppDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.products.category, db.categories.id),
      );

  $$CategoriesTableProcessedTableManager get category {
    final $_column = $_itemColumn<int>('category')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$VariantsTable, List<Variant>> _variantsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.variants,
    aliasName: $_aliasNameGenerator(db.products.id, db.variants.productId),
  );

  $$VariantsTableProcessedTableManager get variantsRefs {
    final manager = $$VariantsTableTableManager(
      $_db,
      $_db.variants,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_variantsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
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

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costPrice => $composableBuilder(
    column: $table.costPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BrandsTableFilterComposer get brand {
    final $$BrandsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brand,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableFilterComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get category {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.category,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> variantsRefs(
    Expression<bool> Function($$VariantsTableFilterComposer f) f,
  ) {
    final $$VariantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.variants,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VariantsTableFilterComposer(
            $db: $db,
            $table: $db.variants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
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

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costPrice => $composableBuilder(
    column: $table.costPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BrandsTableOrderingComposer get brand {
    final $$BrandsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brand,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableOrderingComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get category {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.category,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<double> get costPrice =>
      $composableBuilder(column: $table.costPrice, builder: (column) => column);

  GeneratedColumn<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BrandsTableAnnotationComposer get brand {
    final $$BrandsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brand,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableAnnotationComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get category {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.category,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> variantsRefs<T extends Object>(
    Expression<T> Function($$VariantsTableAnnotationComposer a) f,
  ) {
    final $$VariantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.variants,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VariantsTableAnnotationComposer(
            $db: $db,
            $table: $db.variants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({bool brand, bool category, bool variantsRefs})
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> brand = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<int> category = const Value.absent(),
                Value<double> costPrice = const Value.absent(),
                Value<double> sellingPrice = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                brand: brand,
                model: model,
                category: category,
                costPrice: costPrice,
                sellingPrice: sellingPrice,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int brand,
                required String model,
                required int category,
                required double costPrice,
                required double sellingPrice,
                required int isActive,
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                brand: brand,
                model: model,
                category: category,
                costPrice: costPrice,
                sellingPrice: sellingPrice,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({brand = false, category = false, variantsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (variantsRefs) db.variants],
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
                        if (brand) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.brand,
                                    referencedTable: $$ProductsTableReferences
                                        ._brandTable(db),
                                    referencedColumn: $$ProductsTableReferences
                                        ._brandTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (category) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.category,
                                    referencedTable: $$ProductsTableReferences
                                        ._categoryTable(db),
                                    referencedColumn: $$ProductsTableReferences
                                        ._categoryTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (variantsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          Variant
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._variantsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).variantsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
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

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({bool brand, bool category, bool variantsRefs})
    >;
typedef $$AvailableColorsTableCreateCompanionBuilder =
    AvailableColorsCompanion Function({Value<int> id, required String value});
typedef $$AvailableColorsTableUpdateCompanionBuilder =
    AvailableColorsCompanion Function({Value<int> id, Value<String> value});

final class $$AvailableColorsTableReferences
    extends
        BaseReferences<_$AppDatabase, $AvailableColorsTable, AvailableColor> {
  $$AvailableColorsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$VariantsTable, List<Variant>> _variantsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.variants,
    aliasName: $_aliasNameGenerator(db.availableColors.id, db.variants.color),
  );

  $$VariantsTableProcessedTableManager get variantsRefs {
    final manager = $$VariantsTableTableManager(
      $_db,
      $_db.variants,
    ).filter((f) => f.color.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_variantsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SaleItemsTable, List<SaleItem>>
  _saleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleItems,
    aliasName: $_aliasNameGenerator(db.availableColors.id, db.saleItems.color),
  );

  $$SaleItemsTableProcessedTableManager get saleItemsRefs {
    final manager = $$SaleItemsTableTableManager(
      $_db,
      $_db.saleItems,
    ).filter((f) => f.color.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AvailableColorsTableFilterComposer
    extends Composer<_$AppDatabase, $AvailableColorsTable> {
  $$AvailableColorsTableFilterComposer({
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

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> variantsRefs(
    Expression<bool> Function($$VariantsTableFilterComposer f) f,
  ) {
    final $$VariantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.variants,
      getReferencedColumn: (t) => t.color,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VariantsTableFilterComposer(
            $db: $db,
            $table: $db.variants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> saleItemsRefs(
    Expression<bool> Function($$SaleItemsTableFilterComposer f) f,
  ) {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.color,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AvailableColorsTableOrderingComposer
    extends Composer<_$AppDatabase, $AvailableColorsTable> {
  $$AvailableColorsTableOrderingComposer({
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

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AvailableColorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AvailableColorsTable> {
  $$AvailableColorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  Expression<T> variantsRefs<T extends Object>(
    Expression<T> Function($$VariantsTableAnnotationComposer a) f,
  ) {
    final $$VariantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.variants,
      getReferencedColumn: (t) => t.color,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VariantsTableAnnotationComposer(
            $db: $db,
            $table: $db.variants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> saleItemsRefs<T extends Object>(
    Expression<T> Function($$SaleItemsTableAnnotationComposer a) f,
  ) {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.color,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AvailableColorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AvailableColorsTable,
          AvailableColor,
          $$AvailableColorsTableFilterComposer,
          $$AvailableColorsTableOrderingComposer,
          $$AvailableColorsTableAnnotationComposer,
          $$AvailableColorsTableCreateCompanionBuilder,
          $$AvailableColorsTableUpdateCompanionBuilder,
          (AvailableColor, $$AvailableColorsTableReferences),
          AvailableColor,
          PrefetchHooks Function({bool variantsRefs, bool saleItemsRefs})
        > {
  $$AvailableColorsTableTableManager(
    _$AppDatabase db,
    $AvailableColorsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AvailableColorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AvailableColorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AvailableColorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> value = const Value.absent(),
              }) => AvailableColorsCompanion(id: id, value: value),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String value}) =>
                  AvailableColorsCompanion.insert(id: id, value: value),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AvailableColorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({variantsRefs = false, saleItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (variantsRefs) db.variants,
                    if (saleItemsRefs) db.saleItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (variantsRefs)
                        await $_getPrefetchedData<
                          AvailableColor,
                          $AvailableColorsTable,
                          Variant
                        >(
                          currentTable: table,
                          referencedTable: $$AvailableColorsTableReferences
                              ._variantsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AvailableColorsTableReferences(
                                db,
                                table,
                                p0,
                              ).variantsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.color == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (saleItemsRefs)
                        await $_getPrefetchedData<
                          AvailableColor,
                          $AvailableColorsTable,
                          SaleItem
                        >(
                          currentTable: table,
                          referencedTable: $$AvailableColorsTableReferences
                              ._saleItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AvailableColorsTableReferences(
                                db,
                                table,
                                p0,
                              ).saleItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.color == item.id,
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

typedef $$AvailableColorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AvailableColorsTable,
      AvailableColor,
      $$AvailableColorsTableFilterComposer,
      $$AvailableColorsTableOrderingComposer,
      $$AvailableColorsTableAnnotationComposer,
      $$AvailableColorsTableCreateCompanionBuilder,
      $$AvailableColorsTableUpdateCompanionBuilder,
      (AvailableColor, $$AvailableColorsTableReferences),
      AvailableColor,
      PrefetchHooks Function({bool variantsRefs, bool saleItemsRefs})
    >;
typedef $$VariantsTableCreateCompanionBuilder =
    VariantsCompanion Function({
      Value<int> id,
      required int productId,
      required int color,
      Value<int> isActive,
    });
typedef $$VariantsTableUpdateCompanionBuilder =
    VariantsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int> color,
      Value<int> isActive,
    });

final class $$VariantsTableReferences
    extends BaseReferences<_$AppDatabase, $VariantsTable, Variant> {
  $$VariantsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) => db.products
      .createAlias($_aliasNameGenerator(db.variants.productId, db.products.id));

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AvailableColorsTable _colorTable(_$AppDatabase db) =>
      db.availableColors.createAlias(
        $_aliasNameGenerator(db.variants.color, db.availableColors.id),
      );

  $$AvailableColorsTableProcessedTableManager get color {
    final $_column = $_itemColumn<int>('color')!;

    final manager = $$AvailableColorsTableTableManager(
      $_db,
      $_db.availableColors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_colorTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SizesTable, List<Size>> _sizesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sizes,
    aliasName: $_aliasNameGenerator(db.variants.id, db.sizes.variantId),
  );

  $$SizesTableProcessedTableManager get sizesRefs {
    final manager = $$SizesTableTableManager(
      $_db,
      $_db.sizes,
    ).filter((f) => f.variantId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sizesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesItemsTable, List<ExpenseItem>>
  _expensesItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expensesItems,
    aliasName: $_aliasNameGenerator(db.variants.id, db.expensesItems.variantId),
  );

  $$ExpensesItemsTableProcessedTableManager get expensesItemsRefs {
    final manager = $$ExpensesItemsTableTableManager(
      $_db,
      $_db.expensesItems,
    ).filter((f) => f.variantId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VariantsTableFilterComposer
    extends Composer<_$AppDatabase, $VariantsTable> {
  $$VariantsTableFilterComposer({
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

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AvailableColorsTableFilterComposer get color {
    final $$AvailableColorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.color,
      referencedTable: $db.availableColors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AvailableColorsTableFilterComposer(
            $db: $db,
            $table: $db.availableColors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sizesRefs(
    Expression<bool> Function($$SizesTableFilterComposer f) f,
  ) {
    final $$SizesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sizes,
      getReferencedColumn: (t) => t.variantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SizesTableFilterComposer(
            $db: $db,
            $table: $db.sizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesItemsRefs(
    Expression<bool> Function($$ExpensesItemsTableFilterComposer f) f,
  ) {
    final $$ExpensesItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesItems,
      getReferencedColumn: (t) => t.variantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesItemsTableFilterComposer(
            $db: $db,
            $table: $db.expensesItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VariantsTableOrderingComposer
    extends Composer<_$AppDatabase, $VariantsTable> {
  $$VariantsTableOrderingComposer({
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

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AvailableColorsTableOrderingComposer get color {
    final $$AvailableColorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.color,
      referencedTable: $db.availableColors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AvailableColorsTableOrderingComposer(
            $db: $db,
            $table: $db.availableColors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VariantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VariantsTable> {
  $$VariantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AvailableColorsTableAnnotationComposer get color {
    final $$AvailableColorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.color,
      referencedTable: $db.availableColors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AvailableColorsTableAnnotationComposer(
            $db: $db,
            $table: $db.availableColors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sizesRefs<T extends Object>(
    Expression<T> Function($$SizesTableAnnotationComposer a) f,
  ) {
    final $$SizesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sizes,
      getReferencedColumn: (t) => t.variantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SizesTableAnnotationComposer(
            $db: $db,
            $table: $db.sizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesItemsRefs<T extends Object>(
    Expression<T> Function($$ExpensesItemsTableAnnotationComposer a) f,
  ) {
    final $$ExpensesItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesItems,
      getReferencedColumn: (t) => t.variantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VariantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VariantsTable,
          Variant,
          $$VariantsTableFilterComposer,
          $$VariantsTableOrderingComposer,
          $$VariantsTableAnnotationComposer,
          $$VariantsTableCreateCompanionBuilder,
          $$VariantsTableUpdateCompanionBuilder,
          (Variant, $$VariantsTableReferences),
          Variant,
          PrefetchHooks Function({
            bool productId,
            bool color,
            bool sizesRefs,
            bool expensesItemsRefs,
          })
        > {
  $$VariantsTableTableManager(_$AppDatabase db, $VariantsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VariantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VariantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VariantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int> isActive = const Value.absent(),
              }) => VariantsCompanion(
                id: id,
                productId: productId,
                color: color,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required int color,
                Value<int> isActive = const Value.absent(),
              }) => VariantsCompanion.insert(
                id: id,
                productId: productId,
                color: color,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VariantsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                productId = false,
                color = false,
                sizesRefs = false,
                expensesItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sizesRefs) db.sizes,
                    if (expensesItemsRefs) db.expensesItems,
                  ],
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
                        if (productId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productId,
                                    referencedTable: $$VariantsTableReferences
                                        ._productIdTable(db),
                                    referencedColumn: $$VariantsTableReferences
                                        ._productIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (color) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.color,
                                    referencedTable: $$VariantsTableReferences
                                        ._colorTable(db),
                                    referencedColumn: $$VariantsTableReferences
                                        ._colorTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sizesRefs)
                        await $_getPrefetchedData<
                          Variant,
                          $VariantsTable,
                          Size
                        >(
                          currentTable: table,
                          referencedTable: $$VariantsTableReferences
                              ._sizesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VariantsTableReferences(
                                db,
                                table,
                                p0,
                              ).sizesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.variantId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesItemsRefs)
                        await $_getPrefetchedData<
                          Variant,
                          $VariantsTable,
                          ExpenseItem
                        >(
                          currentTable: table,
                          referencedTable: $$VariantsTableReferences
                              ._expensesItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VariantsTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.variantId == item.id,
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

typedef $$VariantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VariantsTable,
      Variant,
      $$VariantsTableFilterComposer,
      $$VariantsTableOrderingComposer,
      $$VariantsTableAnnotationComposer,
      $$VariantsTableCreateCompanionBuilder,
      $$VariantsTableUpdateCompanionBuilder,
      (Variant, $$VariantsTableReferences),
      Variant,
      PrefetchHooks Function({
        bool productId,
        bool color,
        bool sizesRefs,
        bool expensesItemsRefs,
      })
    >;
typedef $$AvailableSizesTableCreateCompanionBuilder =
    AvailableSizesCompanion Function({Value<int> id, required String value});
typedef $$AvailableSizesTableUpdateCompanionBuilder =
    AvailableSizesCompanion Function({Value<int> id, Value<String> value});

final class $$AvailableSizesTableReferences
    extends BaseReferences<_$AppDatabase, $AvailableSizesTable, AvailableSize> {
  $$AvailableSizesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SizesTable, List<Size>> _sizesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sizes,
    aliasName: $_aliasNameGenerator(db.availableSizes.id, db.sizes.sizeValues),
  );

  $$SizesTableProcessedTableManager get sizesRefs {
    final manager = $$SizesTableTableManager(
      $_db,
      $_db.sizes,
    ).filter((f) => f.sizeValues.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sizesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SaleItemsTable, List<SaleItem>>
  _saleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleItems,
    aliasName: $_aliasNameGenerator(db.availableSizes.id, db.saleItems.size),
  );

  $$SaleItemsTableProcessedTableManager get saleItemsRefs {
    final manager = $$SaleItemsTableTableManager(
      $_db,
      $_db.saleItems,
    ).filter((f) => f.size.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AvailableSizesTableFilterComposer
    extends Composer<_$AppDatabase, $AvailableSizesTable> {
  $$AvailableSizesTableFilterComposer({
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

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sizesRefs(
    Expression<bool> Function($$SizesTableFilterComposer f) f,
  ) {
    final $$SizesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sizes,
      getReferencedColumn: (t) => t.sizeValues,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SizesTableFilterComposer(
            $db: $db,
            $table: $db.sizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> saleItemsRefs(
    Expression<bool> Function($$SaleItemsTableFilterComposer f) f,
  ) {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.size,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AvailableSizesTableOrderingComposer
    extends Composer<_$AppDatabase, $AvailableSizesTable> {
  $$AvailableSizesTableOrderingComposer({
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

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AvailableSizesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AvailableSizesTable> {
  $$AvailableSizesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  Expression<T> sizesRefs<T extends Object>(
    Expression<T> Function($$SizesTableAnnotationComposer a) f,
  ) {
    final $$SizesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sizes,
      getReferencedColumn: (t) => t.sizeValues,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SizesTableAnnotationComposer(
            $db: $db,
            $table: $db.sizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> saleItemsRefs<T extends Object>(
    Expression<T> Function($$SaleItemsTableAnnotationComposer a) f,
  ) {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.size,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AvailableSizesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AvailableSizesTable,
          AvailableSize,
          $$AvailableSizesTableFilterComposer,
          $$AvailableSizesTableOrderingComposer,
          $$AvailableSizesTableAnnotationComposer,
          $$AvailableSizesTableCreateCompanionBuilder,
          $$AvailableSizesTableUpdateCompanionBuilder,
          (AvailableSize, $$AvailableSizesTableReferences),
          AvailableSize,
          PrefetchHooks Function({bool sizesRefs, bool saleItemsRefs})
        > {
  $$AvailableSizesTableTableManager(
    _$AppDatabase db,
    $AvailableSizesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AvailableSizesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AvailableSizesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AvailableSizesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> value = const Value.absent(),
              }) => AvailableSizesCompanion(id: id, value: value),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String value}) =>
                  AvailableSizesCompanion.insert(id: id, value: value),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AvailableSizesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sizesRefs = false, saleItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sizesRefs) db.sizes,
                if (saleItemsRefs) db.saleItems,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sizesRefs)
                    await $_getPrefetchedData<
                      AvailableSize,
                      $AvailableSizesTable,
                      Size
                    >(
                      currentTable: table,
                      referencedTable: $$AvailableSizesTableReferences
                          ._sizesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AvailableSizesTableReferences(
                            db,
                            table,
                            p0,
                          ).sizesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sizeValues == item.id),
                      typedResults: items,
                    ),
                  if (saleItemsRefs)
                    await $_getPrefetchedData<
                      AvailableSize,
                      $AvailableSizesTable,
                      SaleItem
                    >(
                      currentTable: table,
                      referencedTable: $$AvailableSizesTableReferences
                          ._saleItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AvailableSizesTableReferences(
                            db,
                            table,
                            p0,
                          ).saleItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.size == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AvailableSizesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AvailableSizesTable,
      AvailableSize,
      $$AvailableSizesTableFilterComposer,
      $$AvailableSizesTableOrderingComposer,
      $$AvailableSizesTableAnnotationComposer,
      $$AvailableSizesTableCreateCompanionBuilder,
      $$AvailableSizesTableUpdateCompanionBuilder,
      (AvailableSize, $$AvailableSizesTableReferences),
      AvailableSize,
      PrefetchHooks Function({bool sizesRefs, bool saleItemsRefs})
    >;
typedef $$SizesTableCreateCompanionBuilder =
    SizesCompanion Function({
      Value<int> id,
      required int variantId,
      required int productId,
      required int stock,
      required int sizeValues,
      Value<int> isActive,
    });
typedef $$SizesTableUpdateCompanionBuilder =
    SizesCompanion Function({
      Value<int> id,
      Value<int> variantId,
      Value<int> productId,
      Value<int> stock,
      Value<int> sizeValues,
      Value<int> isActive,
    });

final class $$SizesTableReferences
    extends BaseReferences<_$AppDatabase, $SizesTable, Size> {
  $$SizesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VariantsTable _variantIdTable(_$AppDatabase db) => db.variants
      .createAlias($_aliasNameGenerator(db.sizes.variantId, db.variants.id));

  $$VariantsTableProcessedTableManager get variantId {
    final $_column = $_itemColumn<int>('variant_id')!;

    final manager = $$VariantsTableTableManager(
      $_db,
      $_db.variants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_variantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AvailableSizesTable _sizeValuesTable(_$AppDatabase db) =>
      db.availableSizes.createAlias(
        $_aliasNameGenerator(db.sizes.sizeValues, db.availableSizes.id),
      );

  $$AvailableSizesTableProcessedTableManager get sizeValues {
    final $_column = $_itemColumn<int>('size_values')!;

    final manager = $$AvailableSizesTableTableManager(
      $_db,
      $_db.availableSizes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sizeValuesTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExpensesItemsTable, List<ExpenseItem>>
  _expensesItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expensesItems,
    aliasName: $_aliasNameGenerator(db.sizes.id, db.expensesItems.sizeId),
  );

  $$ExpensesItemsTableProcessedTableManager get expensesItemsRefs {
    final manager = $$ExpensesItemsTableTableManager(
      $_db,
      $_db.expensesItems,
    ).filter((f) => f.sizeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SizesTableFilterComposer extends Composer<_$AppDatabase, $SizesTable> {
  $$SizesTableFilterComposer({
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

  ColumnFilters<int> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$VariantsTableFilterComposer get variantId {
    final $$VariantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.variants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VariantsTableFilterComposer(
            $db: $db,
            $table: $db.variants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AvailableSizesTableFilterComposer get sizeValues {
    final $$AvailableSizesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sizeValues,
      referencedTable: $db.availableSizes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AvailableSizesTableFilterComposer(
            $db: $db,
            $table: $db.availableSizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> expensesItemsRefs(
    Expression<bool> Function($$ExpensesItemsTableFilterComposer f) f,
  ) {
    final $$ExpensesItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesItems,
      getReferencedColumn: (t) => t.sizeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesItemsTableFilterComposer(
            $db: $db,
            $table: $db.expensesItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SizesTableOrderingComposer
    extends Composer<_$AppDatabase, $SizesTable> {
  $$SizesTableOrderingComposer({
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

  ColumnOrderings<int> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$VariantsTableOrderingComposer get variantId {
    final $$VariantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.variants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VariantsTableOrderingComposer(
            $db: $db,
            $table: $db.variants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AvailableSizesTableOrderingComposer get sizeValues {
    final $$AvailableSizesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sizeValues,
      referencedTable: $db.availableSizes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AvailableSizesTableOrderingComposer(
            $db: $db,
            $table: $db.availableSizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SizesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SizesTable> {
  $$SizesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$VariantsTableAnnotationComposer get variantId {
    final $$VariantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.variants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VariantsTableAnnotationComposer(
            $db: $db,
            $table: $db.variants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AvailableSizesTableAnnotationComposer get sizeValues {
    final $$AvailableSizesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sizeValues,
      referencedTable: $db.availableSizes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AvailableSizesTableAnnotationComposer(
            $db: $db,
            $table: $db.availableSizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> expensesItemsRefs<T extends Object>(
    Expression<T> Function($$ExpensesItemsTableAnnotationComposer a) f,
  ) {
    final $$ExpensesItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesItems,
      getReferencedColumn: (t) => t.sizeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SizesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SizesTable,
          Size,
          $$SizesTableFilterComposer,
          $$SizesTableOrderingComposer,
          $$SizesTableAnnotationComposer,
          $$SizesTableCreateCompanionBuilder,
          $$SizesTableUpdateCompanionBuilder,
          (Size, $$SizesTableReferences),
          Size,
          PrefetchHooks Function({
            bool variantId,
            bool sizeValues,
            bool expensesItemsRefs,
          })
        > {
  $$SizesTableTableManager(_$AppDatabase db, $SizesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SizesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SizesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SizesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> variantId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> stock = const Value.absent(),
                Value<int> sizeValues = const Value.absent(),
                Value<int> isActive = const Value.absent(),
              }) => SizesCompanion(
                id: id,
                variantId: variantId,
                productId: productId,
                stock: stock,
                sizeValues: sizeValues,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int variantId,
                required int productId,
                required int stock,
                required int sizeValues,
                Value<int> isActive = const Value.absent(),
              }) => SizesCompanion.insert(
                id: id,
                variantId: variantId,
                productId: productId,
                stock: stock,
                sizeValues: sizeValues,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SizesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                variantId = false,
                sizeValues = false,
                expensesItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (expensesItemsRefs) db.expensesItems,
                  ],
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
                        if (variantId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.variantId,
                                    referencedTable: $$SizesTableReferences
                                        ._variantIdTable(db),
                                    referencedColumn: $$SizesTableReferences
                                        ._variantIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (sizeValues) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sizeValues,
                                    referencedTable: $$SizesTableReferences
                                        ._sizeValuesTable(db),
                                    referencedColumn: $$SizesTableReferences
                                        ._sizeValuesTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (expensesItemsRefs)
                        await $_getPrefetchedData<
                          Size,
                          $SizesTable,
                          ExpenseItem
                        >(
                          currentTable: table,
                          referencedTable: $$SizesTableReferences
                              ._expensesItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SizesTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sizeId == item.id,
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

typedef $$SizesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SizesTable,
      Size,
      $$SizesTableFilterComposer,
      $$SizesTableOrderingComposer,
      $$SizesTableAnnotationComposer,
      $$SizesTableCreateCompanionBuilder,
      $$SizesTableUpdateCompanionBuilder,
      (Size, $$SizesTableReferences),
      Size,
      PrefetchHooks Function({
        bool variantId,
        bool sizeValues,
        bool expensesItemsRefs,
      })
    >;
typedef $$SalesTableCreateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      required double total,
      Value<DateTime> createdAt,
    });
typedef $$SalesTableUpdateCompanionBuilder =
    SalesCompanion Function({
      Value<int> id,
      Value<double> total,
      Value<DateTime> createdAt,
    });

final class $$SalesTableReferences
    extends BaseReferences<_$AppDatabase, $SalesTable, Sale> {
  $$SalesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SaleItemsTable, List<SaleItem>>
  _saleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.saleItems,
    aliasName: $_aliasNameGenerator(db.sales.id, db.saleItems.saleId),
  );

  $$SaleItemsTableProcessedTableManager get saleItemsRefs {
    final manager = $$SaleItemsTableTableManager(
      $_db,
      $_db.saleItems,
    ).filter((f) => f.saleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
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

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> saleItemsRefs(
    Expression<bool> Function($$SaleItemsTableFilterComposer f) f,
  ) {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
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

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> saleItemsRefs<T extends Object>(
    Expression<T> Function($$SaleItemsTableAnnotationComposer a) f,
  ) {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTable,
          Sale,
          $$SalesTableFilterComposer,
          $$SalesTableOrderingComposer,
          $$SalesTableAnnotationComposer,
          $$SalesTableCreateCompanionBuilder,
          $$SalesTableUpdateCompanionBuilder,
          (Sale, $$SalesTableReferences),
          Sale,
          PrefetchHooks Function({bool saleItemsRefs})
        > {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SalesCompanion(id: id, total: total, createdAt: createdAt),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double total,
                Value<DateTime> createdAt = const Value.absent(),
              }) => SalesCompanion.insert(
                id: id,
                total: total,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SalesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({saleItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (saleItemsRefs) db.saleItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (saleItemsRefs)
                    await $_getPrefetchedData<Sale, $SalesTable, SaleItem>(
                      currentTable: table,
                      referencedTable: $$SalesTableReferences
                          ._saleItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SalesTableReferences(db, table, p0).saleItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.saleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTable,
      Sale,
      $$SalesTableFilterComposer,
      $$SalesTableOrderingComposer,
      $$SalesTableAnnotationComposer,
      $$SalesTableCreateCompanionBuilder,
      $$SalesTableUpdateCompanionBuilder,
      (Sale, $$SalesTableReferences),
      Sale,
      PrefetchHooks Function({bool saleItemsRefs})
    >;
typedef $$SaleItemsTableCreateCompanionBuilder =
    SaleItemsCompanion Function({
      Value<int> id,
      required int saleId,
      required double price,
      required int quantity,
      required int brand,
      required String model,
      required int size,
      required int color,
      required int productId,
      Value<DateTime> createdAt,
    });
typedef $$SaleItemsTableUpdateCompanionBuilder =
    SaleItemsCompanion Function({
      Value<int> id,
      Value<int> saleId,
      Value<double> price,
      Value<int> quantity,
      Value<int> brand,
      Value<String> model,
      Value<int> size,
      Value<int> color,
      Value<int> productId,
      Value<DateTime> createdAt,
    });

final class $$SaleItemsTableReferences
    extends BaseReferences<_$AppDatabase, $SaleItemsTable, SaleItem> {
  $$SaleItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SalesTable _saleIdTable(_$AppDatabase db) => db.sales.createAlias(
    $_aliasNameGenerator(db.saleItems.saleId, db.sales.id),
  );

  $$SalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<int>('sale_id')!;

    final manager = $$SalesTableTableManager(
      $_db,
      $_db.sales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BrandsTable _brandTable(_$AppDatabase db) => db.brands.createAlias(
    $_aliasNameGenerator(db.saleItems.brand, db.brands.id),
  );

  $$BrandsTableProcessedTableManager get brand {
    final $_column = $_itemColumn<int>('brand')!;

    final manager = $$BrandsTableTableManager(
      $_db,
      $_db.brands,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_brandTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AvailableSizesTable _sizeTable(_$AppDatabase db) =>
      db.availableSizes.createAlias(
        $_aliasNameGenerator(db.saleItems.size, db.availableSizes.id),
      );

  $$AvailableSizesTableProcessedTableManager get size {
    final $_column = $_itemColumn<int>('size')!;

    final manager = $$AvailableSizesTableTableManager(
      $_db,
      $_db.availableSizes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sizeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AvailableColorsTable _colorTable(_$AppDatabase db) =>
      db.availableColors.createAlias(
        $_aliasNameGenerator(db.saleItems.color, db.availableColors.id),
      );

  $$AvailableColorsTableProcessedTableManager get color {
    final $_column = $_itemColumn<int>('color')!;

    final manager = $$AvailableColorsTableTableManager(
      $_db,
      $_db.availableColors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_colorTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SaleItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableFilterComposer({
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

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SalesTableFilterComposer get saleId {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BrandsTableFilterComposer get brand {
    final $$BrandsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brand,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableFilterComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AvailableSizesTableFilterComposer get size {
    final $$AvailableSizesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.size,
      referencedTable: $db.availableSizes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AvailableSizesTableFilterComposer(
            $db: $db,
            $table: $db.availableSizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AvailableColorsTableFilterComposer get color {
    final $$AvailableColorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.color,
      referencedTable: $db.availableColors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AvailableColorsTableFilterComposer(
            $db: $db,
            $table: $db.availableColors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableOrderingComposer({
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

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SalesTableOrderingComposer get saleId {
    final $$SalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableOrderingComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BrandsTableOrderingComposer get brand {
    final $$BrandsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brand,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableOrderingComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AvailableSizesTableOrderingComposer get size {
    final $$AvailableSizesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.size,
      referencedTable: $db.availableSizes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AvailableSizesTableOrderingComposer(
            $db: $db,
            $table: $db.availableSizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AvailableColorsTableOrderingComposer get color {
    final $$AvailableColorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.color,
      referencedTable: $db.availableColors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AvailableColorsTableOrderingComposer(
            $db: $db,
            $table: $db.availableColors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SalesTableAnnotationComposer get saleId {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BrandsTableAnnotationComposer get brand {
    final $$BrandsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brand,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableAnnotationComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AvailableSizesTableAnnotationComposer get size {
    final $$AvailableSizesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.size,
      referencedTable: $db.availableSizes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AvailableSizesTableAnnotationComposer(
            $db: $db,
            $table: $db.availableSizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AvailableColorsTableAnnotationComposer get color {
    final $$AvailableColorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.color,
      referencedTable: $db.availableColors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AvailableColorsTableAnnotationComposer(
            $db: $db,
            $table: $db.availableColors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleItemsTable,
          SaleItem,
          $$SaleItemsTableFilterComposer,
          $$SaleItemsTableOrderingComposer,
          $$SaleItemsTableAnnotationComposer,
          $$SaleItemsTableCreateCompanionBuilder,
          $$SaleItemsTableUpdateCompanionBuilder,
          (SaleItem, $$SaleItemsTableReferences),
          SaleItem,
          PrefetchHooks Function({
            bool saleId,
            bool brand,
            bool size,
            bool color,
          })
        > {
  $$SaleItemsTableTableManager(_$AppDatabase db, $SaleItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> saleId = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> brand = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<int> size = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SaleItemsCompanion(
                id: id,
                saleId: saleId,
                price: price,
                quantity: quantity,
                brand: brand,
                model: model,
                size: size,
                color: color,
                productId: productId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int saleId,
                required double price,
                required int quantity,
                required int brand,
                required String model,
                required int size,
                required int color,
                required int productId,
                Value<DateTime> createdAt = const Value.absent(),
              }) => SaleItemsCompanion.insert(
                id: id,
                saleId: saleId,
                price: price,
                quantity: quantity,
                brand: brand,
                model: model,
                size: size,
                color: color,
                productId: productId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SaleItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({saleId = false, brand = false, size = false, color = false}) {
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
                        if (saleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.saleId,
                                    referencedTable: $$SaleItemsTableReferences
                                        ._saleIdTable(db),
                                    referencedColumn: $$SaleItemsTableReferences
                                        ._saleIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (brand) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.brand,
                                    referencedTable: $$SaleItemsTableReferences
                                        ._brandTable(db),
                                    referencedColumn: $$SaleItemsTableReferences
                                        ._brandTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (size) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.size,
                                    referencedTable: $$SaleItemsTableReferences
                                        ._sizeTable(db),
                                    referencedColumn: $$SaleItemsTableReferences
                                        ._sizeTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (color) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.color,
                                    referencedTable: $$SaleItemsTableReferences
                                        ._colorTable(db),
                                    referencedColumn: $$SaleItemsTableReferences
                                        ._colorTable(db)
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

typedef $$SaleItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleItemsTable,
      SaleItem,
      $$SaleItemsTableFilterComposer,
      $$SaleItemsTableOrderingComposer,
      $$SaleItemsTableAnnotationComposer,
      $$SaleItemsTableCreateCompanionBuilder,
      $$SaleItemsTableUpdateCompanionBuilder,
      (SaleItem, $$SaleItemsTableReferences),
      SaleItem,
      PrefetchHooks Function({bool saleId, bool brand, bool size, bool color})
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<String?> note,
      required int relatedId,
      required double total,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<String?> note,
      Value<int> relatedId,
      Value<double> total,
    });

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, Expense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExpensesItemsTable, List<ExpenseItem>>
  _expensesItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expensesItems,
    aliasName: $_aliasNameGenerator(db.expenses.id, db.expensesItems.expenseId),
  );

  $$ExpensesItemsTableProcessedTableManager get expensesItemsRefs {
    final manager = $$ExpensesItemsTableTableManager(
      $_db,
      $_db.expensesItems,
    ).filter((f) => f.expenseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get relatedId => $composableBuilder(
    column: $table.relatedId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> expensesItemsRefs(
    Expression<bool> Function($$ExpensesItemsTableFilterComposer f) f,
  ) {
    final $$ExpensesItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesItems,
      getReferencedColumn: (t) => t.expenseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesItemsTableFilterComposer(
            $db: $db,
            $table: $db.expensesItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get relatedId => $composableBuilder(
    column: $table.relatedId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get relatedId =>
      $composableBuilder(column: $table.relatedId, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  Expression<T> expensesItemsRefs<T extends Object>(
    Expression<T> Function($$ExpensesItemsTableAnnotationComposer a) f,
  ) {
    final $$ExpensesItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesItems,
      getReferencedColumn: (t) => t.expenseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, $$ExpensesTableReferences),
          Expense,
          PrefetchHooks Function({bool expensesItemsRefs})
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> relatedId = const Value.absent(),
                Value<double> total = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                createdAt: createdAt,
                note: note,
                relatedId: relatedId,
                total: total,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required int relatedId,
                required double total,
              }) => ExpensesCompanion.insert(
                id: id,
                createdAt: createdAt,
                note: note,
                relatedId: relatedId,
                total: total,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({expensesItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (expensesItemsRefs) db.expensesItems,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (expensesItemsRefs)
                    await $_getPrefetchedData<
                      Expense,
                      $ExpensesTable,
                      ExpenseItem
                    >(
                      currentTable: table,
                      referencedTable: $$ExpensesTableReferences
                          ._expensesItemsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ExpensesTableReferences(
                        db,
                        table,
                        p0,
                      ).expensesItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.expenseId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, $$ExpensesTableReferences),
      Expense,
      PrefetchHooks Function({bool expensesItemsRefs})
    >;
typedef $$ExpensesItemsTableCreateCompanionBuilder =
    ExpensesItemsCompanion Function({
      Value<int> id,
      required int expenseId,
      required int variantId,
      required int sizeId,
      required double price,
      required int quantity,
    });
typedef $$ExpensesItemsTableUpdateCompanionBuilder =
    ExpensesItemsCompanion Function({
      Value<int> id,
      Value<int> expenseId,
      Value<int> variantId,
      Value<int> sizeId,
      Value<double> price,
      Value<int> quantity,
    });

final class $$ExpensesItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesItemsTable, ExpenseItem> {
  $$ExpensesItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExpensesTable _expenseIdTable(_$AppDatabase db) =>
      db.expenses.createAlias(
        $_aliasNameGenerator(db.expensesItems.expenseId, db.expenses.id),
      );

  $$ExpensesTableProcessedTableManager get expenseId {
    final $_column = $_itemColumn<int>('expense_id')!;

    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_expenseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VariantsTable _variantIdTable(_$AppDatabase db) =>
      db.variants.createAlias(
        $_aliasNameGenerator(db.expensesItems.variantId, db.variants.id),
      );

  $$VariantsTableProcessedTableManager get variantId {
    final $_column = $_itemColumn<int>('variant_id')!;

    final manager = $$VariantsTableTableManager(
      $_db,
      $_db.variants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_variantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SizesTable _sizeIdTable(_$AppDatabase db) => db.sizes.createAlias(
    $_aliasNameGenerator(db.expensesItems.sizeId, db.sizes.id),
  );

  $$SizesTableProcessedTableManager get sizeId {
    final $_column = $_itemColumn<int>('size_id')!;

    final manager = $$SizesTableTableManager(
      $_db,
      $_db.sizes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sizeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpensesItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesItemsTable> {
  $$ExpensesItemsTableFilterComposer({
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

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  $$ExpensesTableFilterComposer get expenseId {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.expenseId,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VariantsTableFilterComposer get variantId {
    final $$VariantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.variants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VariantsTableFilterComposer(
            $db: $db,
            $table: $db.variants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SizesTableFilterComposer get sizeId {
    final $$SizesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sizeId,
      referencedTable: $db.sizes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SizesTableFilterComposer(
            $db: $db,
            $table: $db.sizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesItemsTable> {
  $$ExpensesItemsTableOrderingComposer({
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

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExpensesTableOrderingComposer get expenseId {
    final $$ExpensesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.expenseId,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableOrderingComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VariantsTableOrderingComposer get variantId {
    final $$VariantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.variants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VariantsTableOrderingComposer(
            $db: $db,
            $table: $db.variants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SizesTableOrderingComposer get sizeId {
    final $$SizesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sizeId,
      referencedTable: $db.sizes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SizesTableOrderingComposer(
            $db: $db,
            $table: $db.sizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesItemsTable> {
  $$ExpensesItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  $$ExpensesTableAnnotationComposer get expenseId {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.expenseId,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VariantsTableAnnotationComposer get variantId {
    final $$VariantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.variants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VariantsTableAnnotationComposer(
            $db: $db,
            $table: $db.variants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SizesTableAnnotationComposer get sizeId {
    final $$SizesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sizeId,
      referencedTable: $db.sizes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SizesTableAnnotationComposer(
            $db: $db,
            $table: $db.sizes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesItemsTable,
          ExpenseItem,
          $$ExpensesItemsTableFilterComposer,
          $$ExpensesItemsTableOrderingComposer,
          $$ExpensesItemsTableAnnotationComposer,
          $$ExpensesItemsTableCreateCompanionBuilder,
          $$ExpensesItemsTableUpdateCompanionBuilder,
          (ExpenseItem, $$ExpensesItemsTableReferences),
          ExpenseItem,
          PrefetchHooks Function({bool expenseId, bool variantId, bool sizeId})
        > {
  $$ExpensesItemsTableTableManager(_$AppDatabase db, $ExpensesItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> expenseId = const Value.absent(),
                Value<int> variantId = const Value.absent(),
                Value<int> sizeId = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<int> quantity = const Value.absent(),
              }) => ExpensesItemsCompanion(
                id: id,
                expenseId: expenseId,
                variantId: variantId,
                sizeId: sizeId,
                price: price,
                quantity: quantity,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int expenseId,
                required int variantId,
                required int sizeId,
                required double price,
                required int quantity,
              }) => ExpensesItemsCompanion.insert(
                id: id,
                expenseId: expenseId,
                variantId: variantId,
                sizeId: sizeId,
                price: price,
                quantity: quantity,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpensesItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({expenseId = false, variantId = false, sizeId = false}) {
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
                        if (expenseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.expenseId,
                                    referencedTable:
                                        $$ExpensesItemsTableReferences
                                            ._expenseIdTable(db),
                                    referencedColumn:
                                        $$ExpensesItemsTableReferences
                                            ._expenseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (variantId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.variantId,
                                    referencedTable:
                                        $$ExpensesItemsTableReferences
                                            ._variantIdTable(db),
                                    referencedColumn:
                                        $$ExpensesItemsTableReferences
                                            ._variantIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (sizeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sizeId,
                                    referencedTable:
                                        $$ExpensesItemsTableReferences
                                            ._sizeIdTable(db),
                                    referencedColumn:
                                        $$ExpensesItemsTableReferences
                                            ._sizeIdTable(db)
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

typedef $$ExpensesItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesItemsTable,
      ExpenseItem,
      $$ExpensesItemsTableFilterComposer,
      $$ExpensesItemsTableOrderingComposer,
      $$ExpensesItemsTableAnnotationComposer,
      $$ExpensesItemsTableCreateCompanionBuilder,
      $$ExpensesItemsTableUpdateCompanionBuilder,
      (ExpenseItem, $$ExpensesItemsTableReferences),
      ExpenseItem,
      PrefetchHooks Function({bool expenseId, bool variantId, bool sizeId})
    >;
typedef $$CachesTableCreateCompanionBuilder =
    CachesCompanion Function({
      Value<int> id,
      Value<int> theme,
      Value<int> passaword,
    });
typedef $$CachesTableUpdateCompanionBuilder =
    CachesCompanion Function({
      Value<int> id,
      Value<int> theme,
      Value<int> passaword,
    });

class $$CachesTableFilterComposer
    extends Composer<_$AppDatabase, $CachesTable> {
  $$CachesTableFilterComposer({
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

  ColumnFilters<int> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get passaword => $composableBuilder(
    column: $table.passaword,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachesTable> {
  $$CachesTableOrderingComposer({
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

  ColumnOrderings<int> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get passaword => $composableBuilder(
    column: $table.passaword,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachesTable> {
  $$CachesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);

  GeneratedColumn<int> get passaword =>
      $composableBuilder(column: $table.passaword, builder: (column) => column);
}

class $$CachesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachesTable,
          Cache,
          $$CachesTableFilterComposer,
          $$CachesTableOrderingComposer,
          $$CachesTableAnnotationComposer,
          $$CachesTableCreateCompanionBuilder,
          $$CachesTableUpdateCompanionBuilder,
          (Cache, BaseReferences<_$AppDatabase, $CachesTable, Cache>),
          Cache,
          PrefetchHooks Function()
        > {
  $$CachesTableTableManager(_$AppDatabase db, $CachesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> theme = const Value.absent(),
                Value<int> passaword = const Value.absent(),
              }) => CachesCompanion(id: id, theme: theme, passaword: passaword),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> theme = const Value.absent(),
                Value<int> passaword = const Value.absent(),
              }) => CachesCompanion.insert(
                id: id,
                theme: theme,
                passaword: passaword,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachesTable,
      Cache,
      $$CachesTableFilterComposer,
      $$CachesTableOrderingComposer,
      $$CachesTableAnnotationComposer,
      $$CachesTableCreateCompanionBuilder,
      $$CachesTableUpdateCompanionBuilder,
      (Cache, BaseReferences<_$AppDatabase, $CachesTable, Cache>),
      Cache,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BrandsTableTableManager get brands =>
      $$BrandsTableTableManager(_db, _db.brands);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$AvailableColorsTableTableManager get availableColors =>
      $$AvailableColorsTableTableManager(_db, _db.availableColors);
  $$VariantsTableTableManager get variants =>
      $$VariantsTableTableManager(_db, _db.variants);
  $$AvailableSizesTableTableManager get availableSizes =>
      $$AvailableSizesTableTableManager(_db, _db.availableSizes);
  $$SizesTableTableManager get sizes =>
      $$SizesTableTableManager(_db, _db.sizes);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$SaleItemsTableTableManager get saleItems =>
      $$SaleItemsTableTableManager(_db, _db.saleItems);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$ExpensesItemsTableTableManager get expensesItems =>
      $$ExpensesItemsTableTableManager(_db, _db.expensesItems);
  $$CachesTableTableManager get caches =>
      $$CachesTableTableManager(_db, _db.caches);
}
