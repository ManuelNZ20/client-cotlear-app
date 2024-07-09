import '../entities/entities.dart';

abstract class ProductDiscountDatasource {
  Future<List<ProductDiscount>> getProductsDiscount();

  Future<ProductDiscount?> getProductDiscountById({
    String idproduct = '',
  });
  Stream<List<ProductDiscount>> getProductsDiscountStream();
}
