import 'dart:async';
import 'package:cotlear_app/features/auth/domain/entities/users.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  // verifyOtp()
  Future<Users> login({required String email, required String password});
  // signUser()
  Future<Users> signUp({
    required String email,
    required String password,
    required String username,
  });
  // authStatus
  Future<Users> checkAuthStatus({String? token});
  // listenToAuthStatus()
  StreamSubscription<AuthState> listenToAuthStatus();
  // isLoggedIn()
  bool isLoggedIn();
  // signOutUser()
  Future<void> signOut();

  Future<Session?> getSessionSupabase();

  Future<Users> googleSignIn();

  Future<void> googleSignOut();
}
