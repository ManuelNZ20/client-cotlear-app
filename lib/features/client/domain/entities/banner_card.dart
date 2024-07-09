class BannerCard {
  final String idBanner;
  final String title;
  final String subTitle;
  final String imgUrl;
  final DateTime createdAt;
  final DateTime expiredAt;
  final bool isActive;
  final String? linkScreen;
  final String titleLink;

  BannerCard({
    required this.idBanner,
    required this.title,
    required this.subTitle,
    required this.imgUrl,
    required this.createdAt,
    required this.expiredAt,
    required this.isActive,
    this.linkScreen = '',
    required this.titleLink,
  });
}
