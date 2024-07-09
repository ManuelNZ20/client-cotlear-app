import 'dart:async';
import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cotlear_app/features/auth/domain/domain.dart';
import 'package:cotlear_app/features/auth/infrastructure/infrastructure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final SupabaseClient supabaseClient;
  final _googleSignIn = GoogleSignIn(scopes: ['email']);
  AuthDatasourceImpl({
    SupabaseClient? supabaseClientDatasource,
  }) : supabaseClient = supabaseClientDatasource ?? Supabase.instance.client;

  @override
  Future<Users> checkAuthStatus({String? token}) async {
    try {
      final getUser = await supabaseClient.auth.getUser();
      final userMetadata = getUser.user?.userMetadata;
      if (userMetadata == null) {
        throw Exception('User metadata is null');
      }
      final user = UserMapper.userJsonToEntity(userMetadata);
      return user;
    } on AuthException catch (e) {
      if (e.statusCode == '400') {
        throw WrongCredentials();
      }
      throw CustomError('Something wrong happend' /* , 1 */);
    } on SocketException catch (_) {
      throw ConnectionTimeout();
    } catch (e) {
      throw CustomError('Something wrong happend' /* , 1 */);
    }
  }

  @override
  bool isLoggedIn() {
    return supabaseClient.auth.currentSession != null;
  }

  @override
  StreamSubscription<AuthState> listenToAuthStatus() {
    final res = supabaseClient.auth.onAuthStateChange.listen((event) => event);
    return res;
  }

  @override
  Future<Users> login({required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final userMetadata = response.session?.user.userMetadata;
      if (userMetadata == null) {
        throw Exception('User metadata is null');
      }
      final user = UserMapper.userJsonToEntity(userMetadata);
      return user;
    } on AuthException catch (e) {
      if (e.statusCode == '400') {
        // invalid login credentials
        throw WrongCredentials();
        // throw CustomError(e.message);
      }
      throw CustomError('Something wrong happend' /* , 1 */);
    } on SocketException catch (_) {
      throw ConnectionTimeout();
    } catch (e) {
      throw CustomError('Something wrong happend' /* , 1 */);
    }
  }

  @override
  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }

  @override
  Future<Users> signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final response = await _signUp(
        inEmail: email,
        inPassword: password,
        inUsername: username,
      );
      final session = response.user;
      if (session == null) {
        throw Exception('Session is null');
      }
      final userMetadata = session.userMetadata!;
      final user = UserMapper.userJsonToEntity(userMetadata);
      return user;
    } on Exception catch (e) {
      throw Exception('Error: ${e.toString()}, Status Code: ');
    }
  }

  @override
  Future<Session?> getSessionSupabase() async {
    return supabaseClient.auth.currentSession;
  }

  @override
  Future<Users> googleSignIn() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign In aborted by user');
      }
      final response = await _signUp(
        inEmail: googleUser.email,
        inPassword: 'Abc123',
        inUsername: 'User Google',
      );
      final session = response.user;
      if (session == null) {
        throw Exception('Session is null');
      }
      final userMetadata = session.userMetadata!;
      final user = UserMapper.userJsonToEntity(userMetadata);
      return user;
    } catch (e) {
      print('Google Sign In Error: ${e.toString()}');
      throw 'Google Sign In Error: ${e.toString()}';
    }
  }

  @override
  Future<void> googleSignOut() async {
    await _googleSignIn.signOut();
  }

  Future<AuthResponse> _signUp({
    String inEmail = '',
    String inPassword = '',
    String inUsername = '',
  }) async {
    return await supabaseClient.auth.signUp(
      email: inEmail,
      password: inPassword,
      emailRedirectTo: 'io.supabase.cotlearapp://login-callback/',
      data: {
        'email': inEmail,
        'password': inPassword,
        'username': inUsername,
      },
    );
  }
}
