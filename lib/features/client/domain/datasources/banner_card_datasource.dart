import '../entities/entities.dart';

abstract class BannerCardDatasource {
  Future<List<BannerCard>> getBanners();
  Future<BannerCard> getBannerById({String id});

  Stream<List<BannerCard>> getBannersStream();
}
