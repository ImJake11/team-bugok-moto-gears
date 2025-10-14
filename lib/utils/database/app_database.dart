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
  TextColumn get brand => text()();
  TextColumn get model => text()();
  TextColumn get category => text()();
  RealColumn get costPrice => real()();
  RealColumn get sellingPrice => real()();
  IntColumn get isActive => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Variant')
class Variants extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  TextColumn get color => text()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
}

@DataClassName('Size')
class Sizes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get variantId => integer().references(Variants, #id)();
  IntColumn get productId => integer().references(Variants, #productId)();
  IntColumn get stock => integer()();
  TextColumn get sizeValues => text()();
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
  TextColumn get brand => text()();
  TextColumn get model => text()();
  TextColumn get size => text()();
  TextColumn get color => text()();
  IntColumn get productId => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// ---------------------------
// DATABASE CLASS
// ---------------------------

@DriftDatabase(
  tables: [Products, Variants, Sizes, Sales, SaleItems],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Increment this when you change your schema
  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 6) {
        await m.addColumn(
          saleItems,
          saleItems.saleId as GeneratedColumn<Object>,
        );
      }
    },
  );
}

// ---------------------------
// DATABASE CONNECTION
// ---------------------------

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, "db.sqlite"));

    final cacheBase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cacheBase;

    return NativeDatabase.createInBackground(file);
  });
}

// Global instance (optional)
final AppDatabase appDatabase = AppDatabase();
