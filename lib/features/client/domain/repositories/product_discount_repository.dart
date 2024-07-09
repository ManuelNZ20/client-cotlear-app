import '../entities/entities.dart';

abstract class ProductDiscountRepository {
  Future<List<ProductDiscount>> getProductsDiscount();

  Future<ProductDiscount?> getProductDiscountById({
    String idproduct = '',
  });
  Stream<List<ProductDiscount>> getProductsDiscountStream();
}
