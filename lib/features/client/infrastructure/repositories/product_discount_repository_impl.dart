import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../datasources/datasources.dart';

class ProductDiscountRepositoryImpl extends ProductDiscountRepository {
  final ProductDiscountDatasource productDiscountDatasource;
  final SupabaseClient supabaseClient;

  ProductDiscountRepositoryImpl({
    ProductDiscountDatasource? productDiscountDatasource,
    required this.supabaseClient,
  }) : productDiscountDatasource = productDiscountDatasource ??
            ProductDiscountDataSourceImpl(
              supabaseClientDatasource: supabaseClient,
            );
  @override
  Future<List<ProductDiscount>> getProductsDiscount() async {
    return await productDiscountDatasource.getProductsDiscount();
  }

  @override
  @override
  Future<ProductDiscount?> getProductDiscountById(
      {String idproduct = ''}) async {
    try {
      final productdiscount = await productDiscountDatasource
          .getProductDiscountById(idproduct: idproduct);
      return productdiscount;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<ProductDiscount>> getProductsDiscountStream() {
    return productDiscountDatasource.getProductsDiscountStream();
  }
}
