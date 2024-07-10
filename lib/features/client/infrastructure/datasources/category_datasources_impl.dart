import 'package:cotlear_app/features/client/infrastructure/model/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../mappers/mappers.dart';
import '../model/model.dart';

class CategoryDatasourceImpl extends CategoryDatasource {
  final SupabaseClient supabaseClient;
  static String nameTable = 'category';

  CategoryDatasourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabaseClient = supabaseClientDatasource ?? Supabase.instance.client;

  @override
  Future<List<CategoryCard>> getCategories() async {
    try {
      final response =
          await supabaseClient.from(nameTable).select().eq('status', true);
      final categories = response
          .map((category) =>
              CategoryMapper.toCategoryEntity(CategoryModel.fromJson(category)))
          .toList();

      return categories;
    } catch (e) {
      throw Exception('Error loading categories $e');
    }
  }

  @override
  Future<CategoryCard> getCategoryById({String id = ''}) async {
    try {
      final response = await supabaseClient.from(nameTable).select().eq(
            'idCategory',
            id,
          );
      final category = response
          .map((category) =>
              CategoryMapper.toCategoryEntity(CategoryModel.fromJson(category)))
          .toList()
          .first;
      return category;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('Category Not Found');
      }
      throw Exception(e);
    } catch (e) {
      throw Exception('Error loading category, error: $e');
    }
  }

  @override
  Stream<List<CategoryCard>> getCategoriesStream() {
    try {
      final response =
          supabaseClient.from(nameTable).stream(primaryKey: ['idCategory']);
      final categories =
          response.map((category) => _responseCategory(category));
      return categories;
    } catch (e) {
      throw Exception('Error loading categories $e');
    }
  }

  List<CategoryCard> _responseCategory(List<Map<String, dynamic>> response) {
    final categories = response
        .map(
          (product) => CategoryMapper.toCategoryEntity(
            CategoryModel.fromJson(product),
          ),
        )
        .toList();
    return categories;
  }
}
