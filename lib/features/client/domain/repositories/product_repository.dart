import '../entities/entities.dart';

abstract class ProductRepository {
  Future<Product> getProductById({String idProduct = ''});

  Future<Product?> getProductWithDiscountById({String idproduct = ''});

  Future<List<Product>> getProducts();

  Future<List<Product>> getProductsOutstanding();

  Future<int> getAmountProducts();

  Future<List<Product>> searchProducts(String textSearch);

  Stream<List<Product>> searchProductsStream(String textSearch);

  Stream<List<Product>> getProductsStream();
}
