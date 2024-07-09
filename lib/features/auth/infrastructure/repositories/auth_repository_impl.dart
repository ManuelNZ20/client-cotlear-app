import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cotlear_app/features/auth/domain/domain.dart';
import '../infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDataSource;
  final SupabaseClient supabaseClient;
  AuthRepositoryImpl({
    AuthDatasource? authDataSource,
    required this.supabaseClient,
  }) : authDataSource = authDataSource ??
            AuthDatasourceImpl(supabaseClientDatasource: supabaseClient);

  @override
  Future<Users> checkAuthStatus({String? token = ''}) {
    return authDataSource.checkAuthStatus(token: token);
  }

  @override
  bool isLoggedIn() {
    return authDataSource.isLoggedIn();
  }

  @override
  StreamSubscription<AuthState> listenToAuthStatus() {
    return authDataSource.listenToAuthStatus();
  }

  @override
  Future<Users> login({required String email, required String password}) {
    return authDataSource.login(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await authDataSource.signOut();
  }

  @override
  Future<Users> signUp(
      {required String email,
      required String password,
      required String username}) async {
    return await authDataSource.signUp(
      email: email,
      password: password,
      username: username,
    );
  }

  @override
  Future<Session?> getSessionSupabase() async {
    final session = await authDataSource.getSessionSupabase();
    return session;
  }

  @override
  Future<Users> googleSignIn() async {
    return await authDataSource.googleSignIn();
  }

  @override
  Future<void> googleSignOut() async {
    await authDataSource.googleSignOut();
  }
}
