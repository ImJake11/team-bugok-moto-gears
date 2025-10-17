import 'package:drift/drift.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/database/repositories/expenses_repository.dart';
import 'package:team_bugok_business/utils/database/repositories/variant_repository.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

class ProductRepository {
  final db = appDatabase;

  final ExpensesRepository expensesRepository = ExpensesRepository();

  Future<void> insertProduct(ProductModel productData) async =>
      _insertProduct(productData);

  Future<List<ProductModel>> retrieveAllProduct() async =>
      _retrieveAllProduct(db);

  Future<void> updateProduct(ProductModel productModel) async =>
      _updateProduct(productModel);

  Future<List<String>> retrieveProductModel() async => _retrieveProductModel();

  Future<ProductModel?> fetchSingleProduct(int id) async =>
      _fetchSingleProduct(id);

  // ============== Private Functions ========//

  Future<ProductModel?> _fetchSingleProduct(int id) async {
    try {
      final query = db.select(db.products).join([
        leftOuterJoin(
          db.variants,
          db.variants.productId.equalsExp(db.products.id),
        ),
        leftOuterJoin(
          db.sizes,
          db.sizes.variantId.equalsExp(db.variants.id),
        ),
      ])..where(db.products.id.equals(id));

      final rows = await query.get();

      if (rows.isEmpty) return null;

      // Read the main product
      final productRow = rows.first.readTable(db.products);

      // Build map: variantId -> VariantModel (with sizes list)
      final Map<int, VariantModel> variantMap = {};

      for (final row in rows) {
        final variantRow = row.readTableOrNull(db.variants);
        final sizeRow = row.readTableOrNull(db.sizes);

        if (variantRow == null) continue;

        // If we haven't seen this variant yet, add it
        variantMap.putIfAbsent(
          variantRow.id,
          () => VariantModel(
            productId: variantRow.productId,
            color: variantRow.color,
            id: variantRow.id,
            isActive: variantRow.isActive,
            sizes: [],
          ),
        );

        // If this row has a size, append it to the variant's sizes list
        if (sizeRow != null) {
          variantMap[variantRow.id]!.sizes.add(
            VariantSizeModel(
              id: sizeRow.id,
              sizeValue: sizeRow.sizeValues,
              stock: sizeRow.stock,
              isActive: sizeRow.isActive,
              productId: sizeRow.productId,
              variantId: sizeRow.variantId,
            ),
          );
        }
      }

      final product = ProductModel(
        id: productRow.id,
        brand: productRow.brand,
        category: productRow.category,
        costPrice: productRow.costPrice,
        createdAt: productRow.createdAt,
        isActive: productRow.isActive,
        model: productRow.model,
        sellingPrice: productRow.sellingPrice,
        variants: variantMap.values.toList(),
      );

      return product;
    } catch (e, st) {
      print('❌ Error in _fetchSingleProduct: $e');
      print('📍 Stack trace:\n$st');
      rethrow;
    }
  }

  Future<void> _insertProduct(ProductModel productData) async {
    try {
      final productId = await db
          .into(db.products)
          .insert(
            ProductsCompanion.insert(
              brand: productData.brand,
              model: productData.model,
              category: productData.category,
              costPrice: productData.costPrice,
              sellingPrice: productData.sellingPrice,
              isActive: productData.isActive,
            ),
          );

      // insert as new expenses
      // and return the id
      final expensesId = await expensesRepository.insertExpenses(
        ExpensesCompanion.insert(
          relatedId: productId,
          note: Value("New Product Entry"),
          total: await expensesRepository.computExpensesTotal(productData),
        ),
      );

      for (var v in productData.variants) {
        final variantId = await db
            .into(db.variants)
            .insert(
              VariantsCompanion.insert(
                productId: productId,
                color: v.color,
              ),
            );

        for (var s in v.sizes) {
          final sizeId = await db
              .into(db.sizes)
              .insert(
                SizesCompanion.insert(
                  productId: productId,
                  variantId: variantId,
                  stock: s.stock,
                  sizeValues: s.sizeValue,
                ),
              );

          // insert as expense item
          await expensesRepository.insertExpenseItem(
            ExpensesItemsCompanion.insert(
              expenseId: expensesId,
              variantId: variantId,
              sizeId: sizeId,
              price: productData.costPrice,
              quantity: s.stock,
            ),
          );
        }
      }
    } catch (e, st) {
      print('❌ Error in _insertProduct: $e');
      print('📍 Stack trace:\n$st');
      rethrow;
    }
  }

  Future<List<ProductModel>> _retrieveAllProduct(db) async {
    try {
      final query = db.select(db.products).join([
        leftOuterJoin(
          db.variants,
          db.variants.productId.equalsExp(db.products.id),
        ),
        leftOuterJoin(db.sizes, db.sizes.variantId.equalsExp(db.variants.id)),
      ]);

      final rows = await query.get();

      final Map<int, ProductModel> productMap = {};

      for (final row in rows) {
        final product = row.readTable(db.products);
        final variant = row.readTableOrNull(db.variants);
        final size = row.readTableOrNull(db.sizes);

        productMap.putIfAbsent(
          product.id,
          () => ProductModel(
            id: product.id,
            brand: product.brand,
            category: product.category,
            model: product.model,
            costPrice: product.costPrice,
            sellingPrice: product.sellingPrice,
            isActive: product.isActive,
            createdAt: product.createdAt,
            variants: [],
          ),
        );

        final currentProduct = productMap[product.id]!;

        // insert variant if existing
        if (variant != null) {
          var existingVariant = currentProduct.variants.firstWhere(
            (v) => v.id == variant.id,
            orElse: () => VariantModel(
              id: variant.id,
              color: variant.color,
              productId: variant.productId,
              sizes: [],
              isActive: variant.isActive,
            ),
          );

          // insert sizes if existing
          if (size != null) {
            existingVariant.sizes.add(
              VariantSizeModel(
                id: size.id,
                variantId: size.variantId,
                sizeValue: size.sizeValues,
                stock: size.stock,
                isActive: size.isActive,
              ),
            );
          }

          if (!currentProduct.variants.any((v) => v.id == existingVariant.id)) {
            currentProduct.variants.add(existingVariant);
          }
        }
      }

      return productMap.values.toList();
    } catch (e, st) {
      print('❌ Error in _retrieveAllProduct: $e');
      print('📍 Stack trace:\n$st');
      rethrow;
    }
  }

  Future<void> _updateProduct(ProductModel productModel) async {
    try {
      await (db.update(db.products)..where(
            (tbl) => tbl.id.equals(productModel.id!),
          ))
          .write(
            ProductsCompanion(
              brand: Value(productModel.brand),
              category: Value(productModel.category),
              costPrice: Value(productModel.costPrice),
              sellingPrice: Value(productModel.sellingPrice),
              model: Value(productModel.model),
              isActive: Value(productModel.isActive),
              id: Value(productModel.id!),
              createdAt: Value(productModel.createdAt),
            ),
          );

      // insert new expenes
      final totalExpenses = await expensesRepository
          .computeExpensesTotalOnProductUpdate(productModel);

      int expensesId = 0;

      // save only as expenses if total is greater than 0
      if (totalExpenses > 0.0) {
        expensesId = await expensesRepository.insertExpenses(
          ExpensesCompanion.insert(
            note: Value("Product Update"),
            relatedId: productModel.id!,
            total: totalExpenses,
          ),
        );
      }

      await VariantRepository().upsertVariant(
        productModel.variants,
        productModel.id!,
        expensesId,
        productModel.costPrice,
      );
    } catch (e, st) {
      print('❌ Error in _updateProduct: $e');
      print('📍 Stack trace:\n$st');
      rethrow;
    }
  }

  Future<List<String>> _retrieveProductModel() async {
    try {
      final models = await (db.select(db.products))
          .map(
            (row) => row.model,
          )
          .get();

      return models;
    } catch (e, st) {
      print('❌ Error in _retrieveProductModel: $e');
      print('📍 Stack trace:\n$st');
      rethrow;
    }
  }
}
