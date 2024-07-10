import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/domain.dart';
import '../mappers/mappers.dart';
import '../model/model.dart';

class BannerCardDatasourceImpl extends BannerCardDatasource {
  final SupabaseClient supabaseClient;
  static String nameTable = 'banner';
  BannerCardDatasourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabaseClient = supabaseClientDatasource ?? Supabase.instance.client;

  @override
  Future<List<BannerCard>> getBanners() async {
    try {
      final response =
          await supabaseClient.from(nameTable).select().eq('isActive', true);
      final banners = _responseBanner(response);
      return banners;
    } catch (e) {
      throw Exception('Error loading banners');
    }
  }

  @override
  Future<BannerCard> getBannerById({String id = ''}) async {
    try {
      final response = await supabaseClient.from(nameTable).select().eq(
            'idBanner',
            id,
          );
      final banner = _responseBanner(response).first;
      return banner;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('Banner Not Found');
      }
      throw Exception(e);
    } catch (e) {
      throw Exception('Error loading banner, error: $e');
    }
  }

  @override
  Stream<List<BannerCard>> getBannersStream() {
    try {
      final response = supabaseClient
          .from(nameTable)
          .stream(primaryKey: ['idBanner']).neq('isActive', false);
      final banners = response.map((event) => _responseBanner(event));
      return banners;
    } catch (e) {
      throw Exception(e);
    }
  }

  List<BannerCard> _responseBanner(List<Map<String, dynamic>> response) {
    final banners = response
        .map((banner) => BannerCardMapper.toBannerCardEntity(
            BannerCardModel.fromJson(banner)))
        .toList();
    return banners;
  }
}
