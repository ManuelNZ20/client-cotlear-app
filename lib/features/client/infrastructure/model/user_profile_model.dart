class UserProfileModel {
  final String id;
  final String email;
  final String password;
  final String username;
  final DateTime createdAt;
  final String? name;
  final String? lastName;
  final String? phone;
  final double? longitude;
  final double? latitude;
  final String? postalCode;
  final String? city;
  final String? address;

  UserProfileModel({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
    required this.createdAt,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.longitude,
    required this.latitude,
    required this.postalCode,
    required this.city,
    required this.address,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        username: json["username"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"] ?? '',
        lastName: json["last_name"] ?? '',
        phone: json["phone"] ?? '',
        longitude: json["longitude"]?.toDouble() ?? 0,
        latitude: json["latitude"]?.toDouble() ?? 0,
        postalCode: json["postalCode"] ?? '',
        city: json["city"] ?? '',
        address: json["address"] ?? '',
      );
}
