import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/domain.dart';
import '../mappers/mappers.dart';
import '../model/model.dart';

class ProductDatasourceImpl implements ProductDatasource {
  final SupabaseClient supabaseClient;
  static String nameTable = 'product';
  ProductDatasourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabaseClient = supabaseClientDatasource ?? Supabase.instance.client;

  @override
  Stream<List<Product>> getProductsStream() {
    final response =
        supabaseClient.from(nameTable).stream(primaryKey: ['idproduct']);
    final products = response.map((event) => _responseProduct(event));
    return products;
  }

  @override
  Future<Product> getProductById({String idProduct = ''}) async {
    try {
      final response = await supabaseClient.from(nameTable).select('''
        *,
        productdiscount(*)
        ''').eq('idproduct', idProduct);
      final product = _responseProduct(response).first;
      return product;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('Product Not Found');
      }
      throw Exception(e);
    } catch (e) {
      throw Exception('Error loading product, product: $e');
    }
  }

  @override
  Future<int> getAmountProducts() async {
    try {
      final response = await supabaseClient
          .from(nameTable)
          .select()
          .count(CountOption.exact);
      return response.count;
    } catch (e) {
      throw Exception('Error loading products $e');
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await supabaseClient.from(nameTable).select('''
        *,
        productdiscount(*)
        ''');
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception('Error loading products ${e.toString()}');
    }
  }

  @override
  Future<List<Product>> getProductsOutstanding() async {
    try {
      final response = await supabaseClient.from(nameTable).select();
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception('Error loading products ${e.toString()}');
    }
  }

  @override
  Future<Product?> getProductWithDiscountById({String idproduct = ''}) async {
    try {
      final response = await supabaseClient
          .from('productdiscount')
          .select()
          .eq('idproduct', idproduct);
      if (response.isEmpty) {
        return null;
      }
      final product = _responseProduct(response).first;
      return product;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Product>> searchProducts(String textSearch) async {
    if (textSearch.isEmpty) return [];
    try {
      final response = await supabaseClient
          .from(nameTable)
          .select()
          .ilike('nameproduct', '%$textSearch%');
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<Product>> searchProductsStream(String textSearch) {
    throw UnimplementedError();
  }

  List<Product> _responseProduct(List<Map<String, dynamic>> response) {
    final products = response
        .map(
          (product) => ProductMapper.toProductEntity(
            ProductModel.fromJson(product),
          ),
        )
        .toList();
    return products;
  }

  @override
  Future<List<Product>> getProductsByCategory(String idCategory) async {
    try {
      final response = await supabaseClient
          .from(nameTable)
          .select()
          .eq('idcategory', idCategory);
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception('Error loading products ${e.toString()}');
    }
  }

  @override
  Future<List<Product>> getProductsWithDiscount() async {
    try {
      final response = await supabaseClient.from(nameTable).select('''
        *,
        productdiscount(*)
        ''').neq('productdiscount', []);
      final products = _responseProduct(response);
      return products;
    } catch (e) {
      throw Exception('Error loading products ${e.toString()}');
    }
  }
}
