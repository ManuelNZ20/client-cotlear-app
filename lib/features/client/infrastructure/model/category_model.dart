class CategoryModel {
  final String idCategory;
  final String name;
  final bool status;
  final String img;

  CategoryModel({
    required this.idCategory,
    required this.name,
    required this.status,
    required this.img,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        idCategory: json['idCategory'].toString(),
        name: json['name'] ?? '',
        status: json['status'] ?? false,
        img: json['img'] ?? '',
      );
}
