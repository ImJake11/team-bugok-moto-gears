import "dart:io";
import "package:drift/drift.dart";
import "package:drift/native.dart";
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

part "app_database.g.dart";

// ---------------------------
// TABLE DEFINITIONS
// ---------------------------

@DataClassName('Product')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get brand => integer().references(Brands, #id)();

  TextColumn get model => text().references(Models, #value)();

  IntColumn get category => integer().references(Categories, #id)();

  RealColumn get costPrice => real()();

  RealColumn get sellingPrice => real()();

  IntColumn get isActive => integer()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Variant')
class Variants extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId => integer().references(Products, #id)();

  IntColumn get color => integer().references(AvailableColors, #id)();

  IntColumn get isActive => integer().withDefault(const Constant(1))();
}

@DataClassName('Size')
class Sizes extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get variantId => integer().references(Variants, #id)();

  IntColumn get productId => integer().references(Variants, #productId)();

  IntColumn get stock => integer()();

  IntColumn get sizeValues => integer().references(AvailableSizes, #id)();

  IntColumn get isActive => integer().withDefault(const Constant(1))();
}

@DataClassName('Sale')
class Sales extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get total => real()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('SaleItem')
class SaleItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get saleId => integer().references(Sales, #id)();

  RealColumn get price => real()();

  IntColumn get quantity => integer()();

  IntColumn get brand => integer().references(Brands, #id)();

  TextColumn get model => text().references(Models, #value)();

  IntColumn get size => integer().references(AvailableSizes, #id)();

  IntColumn get color => integer().references(AvailableColors, #id)();

  IntColumn get productId => integer()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Expense')
class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get note => text().nullable()();

  IntColumn get relatedId => integer()();

  RealColumn get total => real()();

  IntColumn get category => integer().withDefault(Constant(0))();
}

@DataClassName('ExpenseItem')
class ExpensesItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get expenseId => integer().references(Expenses, #id)();

  IntColumn get variantId => integer().references(Variants, #id)();

  IntColumn get sizeId => integer().references(Sizes, #id)();

  RealColumn get price => real()();

  IntColumn get quantity => integer()();
}

@DataClassName('Brand')
class Brands extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get value => text()();
}

@DataClassName('AvailableSize')
class AvailableSizes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get value => text()();
}

@DataClassName('AvailableColor')
class AvailableColors extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get value => text()();
}

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get value => text()();
}

@DataClassName("Cache")
class Caches extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get theme => integer().withDefault(Constant(0))();

  IntColumn get password => integer().withDefault(Constant(102025))();

  IntColumn get isRememberedPin => integer().withDefault(Constant(0))();

  IntColumn get isLoggedIn => integer().withDefault(Constant(0))();
}

@DataClassName("Model")
class Models extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get value => text()();
}
// ---------------------------
// DATABASE CLASS
// ---------------------------

@DriftDatabase(
  tables: [
    Products,
    Variants,
    Sizes,
    Sales,
    SaleItems,
    Expenses,
    ExpensesItems,
    Brands,
    AvailableSizes,
    AvailableColors,
    Categories,
    Caches,
    Models,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Increment this when you change your schema
  @override
  int get schemaVersion => 22;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();

      final existing = await m.database.select(caches).get();

      if (existing.isEmpty) {
        await m.database
            .into(caches)
            .insert(
              CachesCompanion.insert(
                isRememberedPin: Value(0),
                isLoggedIn: Value(0),
                passaword: Value(102025),
                theme: Value(0),
              ),
            );
      }
    },
    // onUpgrade: (Migrator m, int from, int to) async {
    //   if (from == 21) {
    //     await m.alterTable(migration);
    //   }
    // },
  );
}

// ---------------------------
// DATABASE CONNECTION
// ---------------------------

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, "motogears_db.sqlite"));

    final cacheBase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cacheBase;

    return NativeDatabase.createInBackground(file);
  });
}

// Global instance (optional)
final AppDatabase appDatabase = AppDatabase();
