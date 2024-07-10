import 'package:cotlear_app/features/client/domain/domain.dart';

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
  final ProductDiscount? productDiscount;
  final bool? isFavorite;

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
    required this.productDiscount,
    this.isFavorite = false,
  });

  Product copyWith({
    String? idProduct,
    String? nameProduct,
    String? brand,
    String? description,
    bool? status,
    String? img,
    double? price,
    int? amount, //uni,
    DateTime? createAt,
    DateTime? updateAt,
    DateTime? expireProduct,
    int? idCategory,
    ProductDiscount? productDiscount,
    bool? isFavorite,
  }) =>
      Product(
        idProduct: idProduct ?? this.idProduct,
        nameProduct: nameProduct ?? this.nameProduct,
        brand: brand ?? this.brand,
        description: description ?? this.description,
        status: status ?? this.status,
        img: img ?? this.img,
        price: price ?? this.price,
        amount: amount ?? this.amount,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
        expireProduct: expireProduct ?? this.expireProduct,
        idCategory: idCategory ?? this.idCategory,
        productDiscount: productDiscount ?? this.productDiscount,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
