import '../entities/entities.dart';

abstract class BannerCardRepository {
  Future<List<BannerCard>> getBanners();
  Future<BannerCard> getBannerById({String id});

  Stream<List<BannerCard>> getBannersStream();
}
