import 'product.dart';

class ProductDiscount {
  final String idproductdiscount;
  final String idproduct;
  final double discountpercentage; //discount_percentage
  final DateTime createdAt; //created_at
  final Product product;

  ProductDiscount({
    required this.idproductdiscount,
    required this.idproduct,
    required this.discountpercentage,
    required this.createdAt,
    required this.product,
  });
}
