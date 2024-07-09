import '../entities/entities.dart';

abstract class UserDatasource {
  Future<UserProfile> updateUser({
    String id,
    String email,
    String password,
    String username,
    DateTime createdAt,
    String name,
    String lastName,
    String phone,
    double longitude,
    double latitude,
    String postalCode,
    String city,
    String address,
  });

  Future<bool> updateLocationUser({
    String email,
    double longitude,
    double latitude,
  });

  Future<UserProfile> getUserByEmail(String email);

  Future<UserProfile> getUserByUserName(String username);

  Future<List<UserProfile>> getUsers();
}
