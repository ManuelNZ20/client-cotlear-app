import '../entities/entities.dart';

abstract class CategoryDatasource {
  Future<List<CategoryCard>> getCategories();
  Future<CategoryCard> getCategoryById({String id});

  Stream<List<CategoryCard>> getCategoriesStream();
}
