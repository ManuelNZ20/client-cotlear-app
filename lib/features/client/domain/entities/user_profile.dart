class UserProfile {
  final String id;
  final String email;
  final String password;
  final String username;
  final DateTime createdAt;
  final String name;
  final String lastName;
  final String phone;
  final double longitude;
  final double latitude;
  final String postalCode;
  final String city;
  final String address;

  UserProfile({
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
}
