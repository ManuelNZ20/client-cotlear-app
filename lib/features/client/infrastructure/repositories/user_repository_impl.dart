import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/domain.dart';
import '../datasources/datasources.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasource userDatasource;
  final SupabaseClient supabaseClient;

  UserRepositoryImpl({
    UserDatasource? userDatasource,
    required this.supabaseClient,
  }) : userDatasource = userDatasource ??
            UserDatasourceImpl(
              supabaseClientDatasource: supabaseClient,
            );

  @override
  Future<UserProfile> getUserByEmail(String email) async {
    final user = await userDatasource.getUserByEmail(email);
    return user;
  }

  @override
  Future<UserProfile> getUserByUserName(String username) async {
    final user = await userDatasource.getUserByUserName(username);
    return user;
  }

  @override
  Future<List<UserProfile>> getUsers() async {
    return await userDatasource.getUsers();
  }

  @override
  Future<UserProfile> updateUser({
    String id = '',
    String email = '',
    String password = '',
    String username = '',
    DateTime? createdAt,
    String name = '',
    String lastName = '',
    String phone = '',
    double longitude = 0,
    double latitude = 0,
    String postalCode = '',
    String city = '',
    String address = '',
  }) async {
    try {
      return await userDatasource.updateUser(
        id: id,
        email: email,
        password: password,
        username: username,
        createdAt: createdAt!,
        name: name,
        lastName: lastName,
        phone: phone,
        longitude: longitude,
        latitude: latitude,
        postalCode: postalCode,
        city: city,
        address: address,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> updateLocationUser({
    String email = '',
    double longitude = 0,
    double latitude = 0,
  }) async {
    return await userDatasource.updateLocationUser(
      email: email,
      longitude: longitude,
      latitude: latitude,
    );
  }
}
