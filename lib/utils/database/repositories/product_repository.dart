import 'package:drift/drift.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/database/repositories/variant_repository.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

class ProductRepository {
  final db = appDatabase;

  Future<void> insertProduct(ProductModel productData) async =>
      _insertProduct(productData);

  Future<List<ProductModel>> retrieveAllProduct() async =>
      _retrieveAllProduct(db);

  Future<void> updateProduct(ProductModel productModel) async =>
      _updateProduct(productModel);

  Future<List<String>> retrieveProductModel() async => _retrieveProductModel();

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
          await db
              .into(db.sizes)
              .insert(
                SizesCompanion.insert(
                  productId: productId,
                  variantId: variantId,
                  stock: s.stock,
                  sizeValues: s.sizeValue,
                ),
              );
        }
      }
    } catch (e) {
      print("Failed to save product");
      print(e);
    }
  }

  Future<List<ProductModel>> _retrieveAllProduct(db) async {
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
  }

  Future<void> _updateProduct(
    ProductModel productModel,
  ) async {
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

    await VariantRepository().upservariant(
      productModel.variants,
      productModel.id!,
    );
  }

  Future<List<String>> _retrieveProductModel() async {
    final models = await (db.select(db.products))
        .map(
          (row) => row.model,
        )
        .get();

    return models;
  }
}
