class ProductDiscountModel {
  final String idproductdiscount;
  final String idproduct;
  final double discountPercentage;
  final DateTime createdAt;

  ProductDiscountModel({
    required this.idproductdiscount,
    required this.idproduct,
    required this.discountPercentage,
    required this.createdAt,
  });

  factory ProductDiscountModel.fromJson(Map<String, dynamic> json) =>
      ProductDiscountModel(
        idproductdiscount: json["idproductdiscount"],
        idproduct: json["idproduct"],
        discountPercentage:
            double.parse(json["discount_percentage"].toString()),
        createdAt: DateTime.parse(json["created_at"]),
      );
}
