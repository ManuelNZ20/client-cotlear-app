import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../datasources/category_datasources_impl.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDatasource categoryDataSource;
  final SupabaseClient supabaseClient;

  CategoryRepositoryImpl({
    CategoryDatasource? categoryDataSource,
    required this.supabaseClient,
  }) : categoryDataSource = categoryDataSource ??
            CategoryDatasourceImpl(supabaseClientDatasource: supabaseClient);

  @override
  Future<List<CategoryCard>> getCategories() async {
    final categories = await categoryDataSource.getCategories();
    return categories;
  }

  @override
  Future<CategoryCard> getCategoryById({String id = ''}) async {
    final category = await categoryDataSource.getCategoryById(id: id);
    return category;
  }

  @override
  Stream<List<CategoryCard>> getCategoriesStream() {
    return categoryDataSource.getCategoriesStream();
  }
}
