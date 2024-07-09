class Users {
  final String id;
  final String email;
  final String password;
  final String? name;
  final String? lastName;
  final String? accountCreated;
  final String? accountStatus;
  final int? idTypeUser;
  final String? city;
  final String? postalCode;
  final double? latitude;
  final double? longitude;
  final int? age;
  final String? gender;
  final String? userName;

  Users({
    required this.id,
    required this.email,
    required this.password,
    this.name,
    this.lastName,
    this.accountCreated,
    this.accountStatus,
    this.idTypeUser = 2,
    this.city,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.age,
    this.gender,
    this.userName,
  });

  bool get isAdmin => idTypeUser == 1;
}
