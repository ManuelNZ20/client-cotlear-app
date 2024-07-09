import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/domain.dart';
import '../mappers/mappers.dart';
import '../model/model.dart';

class UserDatasourceImpl extends UserDatasource {
  final SupabaseClient supabaseClient;
  static String nameTable = 'profiles';
  UserDatasourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabaseClient = supabaseClientDatasource ?? Supabase.instance.client;

  @override
  Future<UserProfile> getUserByEmail(String email) async {
    try {
      final response =
          await supabaseClient.from(nameTable).select().eq('email', email);
      final user = _responseUser(response).first;
      return user;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('Product Not Found');
      }
      throw Exception(e);
    } catch (e) {
      throw Exception('Error loading user, product: $e');
    }
  }

  @override
  Future<UserProfile> getUserByUserName(String username) async {
    try {
      final response = await supabaseClient
          .from(nameTable)
          .select()
          .eq('username', username);
      final user = _responseUser(response).first;
      return user;
    } on AuthException catch (e) {
      if (e.statusCode == '404') {
        throw Exception('Product Not Found');
      }
      throw Exception(e);
    } catch (e) {
      throw Exception('Error loading product, product: $e');
    }
  }

  @override
  Future<List<UserProfile>> getUsers() async {
    try {
      final response = await supabaseClient.from(nameTable).select();
      final usersProfile = _responseUser(response);
      return usersProfile;
    } catch (e) {
      throw Exception(e);
    }
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
      final response = await supabaseClient
          .from(nameTable)
          .update({
            'password': password,
            'username': username,
            'name': name,
            'last_name': lastName,
            'phone': phone,
            'longitude': longitude,
            'latitude': latitude,
            'postalCode': postalCode,
            'city': city,
            'address': address,
          })
          .eq('email', email)
          .select();
      final user = _responseUser(response).first;
      return user;
    } catch (e) {
      print('error update $e');
      throw Exception(e);
    }
  }

  @override
  Future<bool> updateLocationUser({
    String email = '',
    double longitude = 0,
    double latitude = 0,
  }) async {
    try {
      final response = await supabaseClient
          .from(nameTable)
          .update({
            'longitude': longitude,
            'latitude': latitude,
          })
          .eq('email', email)
          .select();
      return response.isNotEmpty;
    } catch (e) {
      print('error update $e');
      return false;
    }
  }

  List<UserProfile> _responseUser(List<Map<String, dynamic>> response) {
    final usersProfiles = response
        .map((u) =>
            UserProfileMapper.toUserProfileEntity(UserProfileModel.fromJson(u)))
        .toList();
    return usersProfiles;
  }
}
