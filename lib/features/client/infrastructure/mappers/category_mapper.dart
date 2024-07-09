import '../../domain/domain.dart';
import '../model/model.dart';

class CategoryMapper {
  static CategoryCard toCategoryEntity(CategoryModel category) => CategoryCard(
        idCategory: category.idCategory,
        name: category.name,
        status: category.status,
        img: category.img,
      );
}
