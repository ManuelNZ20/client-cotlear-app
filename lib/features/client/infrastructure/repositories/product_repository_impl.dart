import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../datasources/datasources.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource productDataSource;
  final SupabaseClient supabaseClient;

  ProductRepositoryImpl({
    ProductDatasource? productDataSource,
    required this.supabaseClient,
  }) : productDataSource = productDataSource ??
            ProductDatasourceImpl(
              supabaseClientDatasource: supabaseClient,
            );

  @override
  Future<int> getAmountProducts() async {
    return await productDataSource.getAmountProducts();
  }

  @override
  Future<Product> getProductById({String idProduct = ''}) async {
    final product =
        await productDataSource.getProductById(idProduct: idProduct);
    return product;
  }

  @override
  Future<List<Product>> getProducts() async {
    return await productDataSource.getProducts();
  }

  @override
  Future<List<Product>> getProductsOutstanding() async {
    return await productDataSource.getProductsOutstanding();
  }

  @override
  Future<Product?> getProductWithDiscountById({String idproduct = ''}) async {
    try {
      final product = await productDataSource.getProductWithDiscountById(
          idproduct: idproduct);
      if (product == null) {
        return null;
      }
      return product;
    } catch (e) {
      print('Error get Product With Discount $e');
      return null;
    }
  }

  @override
  Stream<List<Product>> getProductsStream() {
    return productDataSource.getProductsStream();
  }

  @override
  Future<List<Product>> searchProducts(String textSearch) async {
    final searchProducts = await productDataSource.searchProducts(textSearch);
    return searchProducts;
  }

  @override
  Stream<List<Product>> searchProductsStream(String textSearch) {
    final searchProducts = productDataSource.searchProductsStream(textSearch);
    return searchProducts;
  }
}
