import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import "package:team_bugok_business/utils/model/product_model.dart";

class InventoryDB {
  Future<Database> getInventoryDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "inventory_database.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE inventory (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_name TEXT,
        category TEXT,
        color TEXT,
        size TEXT,
        cost_price REAL,
        selling_price REAL,
        stock INTEGER,
        is_active INTEGER,
        date_added TEXT
        )''');
      },
    );
  }

  Future<void> insertProduct(ProductModel data) async {
    final db = await getInventoryDb();

    try {
      await db.insert(
        'inventory',
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Error();
    }
  }

  Future<List<ProductModel>> retriveAllProducts() async {
    final db = await getInventoryDb();

    final List<Map<String, Object?>> productsMap = await db.query("inventory");

    return [
      for (final product in productsMap)
        ProductModel(
          id: product['id'] as int,
          productName: product['product_name'] as String,
          dateAdded: product['date_added'] as String,
          category: product['category'] as String,
          color: product['color'] as String,
          size: product['size'] as String,
          stock: product['stock'] as int,
          costPrice: product['cost_price'] as double,
          sellingPrice: product['selling_price'] as double,
          isActive: product['is_active'] as int,
        ),
    ];
  }
}
