import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:team_bugok_business/utils/database/repositories/expenses_repository.dart';
import 'package:team_bugok_business/utils/database/repositories/variant_repository.dart';
import 'package:team_bugok_business/utils/model/expense_item_model_supabase.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

class ProductRepository {
  final SupabaseClient supabase;
  final ExpensesRepository expensesRepository;
  final VariantRepository variantRepository;

  ProductRepository()
    : supabase = Supabase.instance.client,
      variantRepository = VariantRepository(),
      expensesRepository = ExpensesRepository();

  Future<void> insertProduct(ProductModel productData) async =>
      _insertProduct(productData);

  Future<List<ProductModel>> retrieveAllProduct() async =>
      _retrieveAllProduct();

  Future<void> updateProduct(ProductModel productModel) async =>
      _updateProduct(productModel);

  Future<List<String>> retrieveProductModel() async => _retrieveProductModel();

  Future<ProductModel?> fetchSingleProduct(int id) async =>
      _fetchSingleProduct(id);

  Future<List<ProductModel>> searchProduct(String query) async =>
      _searchProduct(query);

  // ============== Private Functions ========//

  Future<ProductModel?> _fetchSingleProduct(int id) async {
    try {
      final result = await supabase
          .from('product')
          .select('''
          *,
          variant(
            *,
              size(*)
            )
          ''')
          .eq("id", id);

      if (result.isEmpty) {
        return null;
      }
      ProductModel product = ProductModel.fromJson(result.first);

      print("✅ Product fetched succesfful");
      return product;
    } catch (e, st) {
      print('Error in _fetchSingleProduct: $e');
      print('Stack trace:\n$st');
      rethrow;
    }
  }

  Future<void> _insertProduct(ProductModel productData) async {
    try {
      final productDataMap = productData.toMap();

      productDataMap['created_at'] = DateTime.now().millisecondsSinceEpoch;

      // insert new product
      final newEntry = await supabase
          .from('product')
          .insert(productDataMap)
          .select();

      final productId = newEntry.first['id'];

      // insert as new expenses
      // and return the id
      final total = await expensesRepository.computExpensesTotal(productData);
      final expensesId = await expensesRepository.insertExpenses(
        ExpensesModel(
          note: "New Product Entry",
          relatedId: productId,
          category: 0,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          total: total,
        ),
      );

      for (var v in productData.variants) {
        final newVariant = v;

        v.productId = productId;
        final newVariantEntry = await supabase
            .from('variant')
            .insert(newVariant.toMap())
            .select();

        final variantId = newVariantEntry.first['id'];

        // insert sizes
        for (var s in v.sizes) {
          final newSize = s;
          newSize.productId = productId;
          newSize.variantId = variantId;

          final newSizeEntry = await supabase
              .from('size')
              .insert(newSize.toMap())
              .select();

          final sizeId = newSizeEntry.first['id'];

          // insert as expense item
          await expensesRepository.insertExpenseItem(
            ExpenseItemModelSupabase(
              expenseId: expensesId,
              price: productData.sellingPrice,
              quantity: s.stock,
              variantId: variantId,
              sizeId: sizeId,
            ),
          );
        }
      }
      print('✅ New Product Inserted Successfully');
    } catch (e, st) {
      print('Error in _insertProduct: $e');
      print('Stack trace:\n$st');
      rethrow;
    }
  }

  Future<List<ProductModel>> _retrieveAllProduct() async {
    try {
      final result = await supabase.from('product').select('''
            *, 
            variant(
            *,
              size(*)
            )
            ''');

      final List<ProductModel> products = result.map<ProductModel>(
        (json) {
          return ProductModel.fromJson(json);
        },
      ).toList();

      return products;
    } catch (e, st) {
      print('❌ Error in _retrieveAllProduct: $e');
      print('📍 Stack trace:\n$st');
      rethrow;
    }
  }

  Future<void> _updateProduct(ProductModel productModel) async {
    try {
      final productDataMap = productModel.toMap();

      // remove [created_at] to preserve original date
      productDataMap.remove('created_at');

      if (productModel.id == null) return;

      // update product first
      await supabase
          .from('product')
          .update(productModel.toMap())
          .eq(
            'id',
            productModel.id!,
          );

      // insert new expenes
      final totalExpenses = await expensesRepository
          .computeExpensesTotalOnProductUpdate(productModel);

      int expensesId = 0;

      // save only as expenses if total is greater than 0
      if (totalExpenses > 0.0) {
        expensesId = await expensesRepository.insertExpenses(
          ExpensesModel(
            category: 0,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            total: totalExpenses,
            note: "Product Update",
            relatedId: productModel.id,
          ),
        );
      }

      // update variants
      await variantRepository.upsertVariant(
        productModel.variants,
        productModel.id!,
        expensesId,
        productModel.costPrice,
      );

      print("✅ Product Updated");
    } catch (e, st) {
      print('[Product Repository] Error in _updateProduct: $e');
      print('Stack trace:\n$st');
      rethrow;
    }
  }

  Future<List<String>> _retrieveProductModel() async {
    try {
      final result = await supabase.from('product').select('model_value');

      List<String> models = result.map<String>((e) => e['model']).toList();

      return models;
    } catch (e, st) {
      print('❌ Error in _retrieveProductModel: $e');
      print('📍 Stack trace:\n$st');
      rethrow;
    }
  }

  Future<List<ProductModel>> _searchProduct(String query) async {
    try {
      final res = await supabase
          .from('product')
          .select('''
            *,
            variant(
              *,
                size(
                  *
                )
            )
            ''')
          .ilike('model_value', "%$query%");

      final results = res
          .map(
            (e) => ProductModel.fromJson(e),
          )
          .toList();

      print('✅ Search Product Successfully');
      return results;
    } catch (e, st) {
      print('Failed to search products $e');
      print(st);
      rethrow;
    }
  }
}
