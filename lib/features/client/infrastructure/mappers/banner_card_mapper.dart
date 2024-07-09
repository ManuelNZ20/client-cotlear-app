import '../../domain/domain.dart';
import '../model/model.dart';

class BannerCardMapper {
  static BannerCard toBannerCardEntity(BannerCardModel banner) => BannerCard(
        idBanner: banner.idBanner,
        title: banner.title,
        subTitle: banner.subTitle,
        imgUrl: banner.imgUrl,
        createdAt: banner.createdAt,
        expiredAt: banner.expiredAt,
        linkScreen: banner.linkScreen,
        isActive: banner.isActive,
        titleLink: banner.titleLink,
      );
}
