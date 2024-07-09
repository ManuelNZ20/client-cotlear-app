class BannerCardModel {
  final String idBanner;
  final String title;
  final String subTitle;
  final String imgUrl;
  final DateTime createdAt;
  final DateTime expiredAt;
  final dynamic linkScreen;
  final bool isActive;
  final String titleLink;

  BannerCardModel({
    required this.idBanner,
    required this.title,
    required this.subTitle,
    required this.imgUrl,
    required this.createdAt,
    required this.expiredAt,
    required this.linkScreen,
    required this.isActive,
    required this.titleLink,
  });

  factory BannerCardModel.fromJson(Map<String, dynamic> json) =>
      BannerCardModel(
        idBanner: json["idBanner"].toString(),
        title: json["title"] ?? '',
        subTitle: json["subTitle"] ?? '',
        imgUrl: json["imgUrl"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        expiredAt: DateTime.parse(json["expired_at"]),
        linkScreen: json["linkScreen"] ?? '',
        isActive: json['isActive'] ?? false,
        titleLink: json["titleLink"] ?? '',
      );
}
