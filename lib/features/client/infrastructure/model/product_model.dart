class ProductModel {
  final String idproduct;
  final String nameproduct;
  final String brand;
  final String description;
  final bool status;
  final String imgproduct;
  final double price;
  final int amount;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime expireProduct;
  final int idcategory;

  ProductModel({
    required this.idproduct,
    required this.nameproduct,
    required this.brand,
    required this.description,
    required this.status,
    required this.imgproduct,
    required this.price,
    required this.amount,
    required this.createAt,
    required this.updateAt,
    required this.expireProduct,
    required this.idcategory,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        idproduct: json["idproduct"],
        nameproduct: json["nameproduct"],
        brand: json["brand"],
        description: json["description"],
        status: json["statusproduct"],
        imgproduct: json["imgproduct"],
        price: double.parse(json["price"].toString()),
        amount: int.parse(json["amount"].toString()),
        createAt:
            DateTime.parse(json["create_at"] ?? DateTime.now().toString()),
        updateAt:
            DateTime.parse(json["update_at"] ?? DateTime.now().toString()),
        expireProduct:
            DateTime.parse(json["expire_product"] ?? DateTime.now().toString()),
        idcategory: json["idcategory"],
      );
}
