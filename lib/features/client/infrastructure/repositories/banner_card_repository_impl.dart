import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/domain.dart';
import '../datasources/datasources.dart';

class BannerCardRepositoryImpl extends BannerCardRepository {
  final BannerCardDatasource bannerDataSource;
  final SupabaseClient supabaseClient;

  BannerCardRepositoryImpl({
    BannerCardDatasource? bannerDataSource,
    required this.supabaseClient,
  }) : bannerDataSource = bannerDataSource ??
            BannerCardDatasourceImpl(supabaseClientDatasource: supabaseClient);

  @override
  Future<List<BannerCard>> getBanners() async {
    return await bannerDataSource.getBanners();
  }

  @override
  Future<BannerCard> getBannerById({String id = ''}) async {
    return await bannerDataSource.getBannerById(id: id);
  }

  @override
  Stream<List<BannerCard>> getBannersStream() {
    return bannerDataSource.getBannersStream();
  }
}
