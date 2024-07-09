class Product {
  final String idProduct;
  final String nameProduct;
  final String brand;
  final String description;
  final bool status;
  final String img;
  final double price;
  final int amount; //unit
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime expireProduct;
  final int idCategory;

  Product({
    required this.idProduct,
    required this.nameProduct,
    required this.brand,
    required this.description,
    required this.status,
    required this.img,
    required this.price,
    required this.amount,
    required this.createAt,
    required this.updateAt,
    required this.expireProduct,
    required this.idCategory,
  });
}
