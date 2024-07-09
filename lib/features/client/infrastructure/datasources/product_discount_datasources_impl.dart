import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../mappers/mappers.dart';
import '../model/model.dart';

class ProductDiscountDataSourceImpl extends ProductDiscountDatasource {
  final SupabaseClient supabaseClient;
  static String nameTable = 'productdiscount';

  ProductDiscountDataSourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabaseClient = supabaseClientDatasource ?? Supabase.instance.client;
  @override
  Future<List<ProductDiscount>> getProductsDiscount() async {
    try {
      final response = await supabaseClient.from(nameTable).select('''
        *,
        product(*)
        ''');
      final productsDiscount = _responseProductDiscount(response);
      return productsDiscount;
    } on AuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ProductDiscount?> getProductDiscountById(
      {String idproduct = ''}) async {
    try {
      final response = await supabaseClient.from(nameTable).select('''
              *,
              product(*)
            ''').eq('idproduct', idproduct);
      final productDiscount = _responseProductDiscount(response).first;
      return productDiscount;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('ProductDiscount Not Found');
      }
      throw Exception(e);
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<List<ProductDiscount>> getProductsDiscountStream() {
    try {
      final response = supabaseClient
          .from(nameTable)
          .stream(primaryKey: ['idproductdiscount']);
      final productsDiscount =
          response.map((event) => _responseProductDiscount(event));
      return productsDiscount;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  List<ProductDiscount> _responseProductDiscount(
      List<Map<String, dynamic>> response) {
    final productsDiscount = response
        .map((e) => ProductDiscountMapper.toProductEntity(
            ProductDiscountModel.fromJson(e)))
        .toList();
    return productsDiscount;
  }
}
