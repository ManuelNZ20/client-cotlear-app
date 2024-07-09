import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cotlear_app/features/auth/domain/domain.dart';
import 'package:cotlear_app/features/auth/infrastructure/infrastructure.dart';
import 'package:cotlear_app/shared/shared.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final supabaseClientDatasource = ref.watch(supabaseClientProvider);
  final authRepository = AuthRepositoryImpl(
      supabaseClient:
          supabaseClientDatasource); // en mi authRepository se encuentran mis casos de uso
  return AuthNotifier(
    authRepository: authRepository,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  AuthNotifier({
    required this.authRepository,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.login(email: email, password: password);
      _setLoggedUser(user);
    } on WrongCredentials {
      logout(errorMessage: 'Credenciales no son correctas');
    } on ConnectionTimeout {
      logout(errorMessage: 'No cuenta con conexión a internet');
    } catch (e) {
      logout(errorMessage: 'Error no controlado, ${e.toString()}');
    }
  }

  Future<void> register(
    String email,
    String password,
    String username,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.signUp(
        email: email,
        password: password,
        username: username,
      );
      _setLoggedUser(user);
    } catch (e) {
      logout(errorMessage: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.googleSignIn();
      _setLoggedUser(user);
    } on WrongCredentials {
      logout(errorMessage: 'Credenciales no son correctas');
    } on ConnectionTimeout {
      logout(errorMessage: 'No cuenta con conexión a internet');
    } catch (e) {
      logout(errorMessage: 'Error no controlado, ${e.toString()}');
    }
  }

  void checkAuthStatus() async {
    final session = await authRepository.getSessionSupabase();
    if (session == null) return logout();
    try {
      final user =
          await authRepository.checkAuthStatus(token: session.refreshToken);
      _setLoggedUser(user);
    } catch (e) {
      logout(errorMessage: 'CheckAuthStatus');
    }
  }

  void _setLoggedUser(Users user) async {
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
      messageRegister: '',
    );
  }

  Future<void> logout({String? errorMessage}) async {
    state = state.copyWith(
      authStatus: AuthStatus.noAuthenticated,
      user: null,
      errorMessage: errorMessage ?? '',
      messageRegister: '',
    );
    authRepository.signOut();
    authRepository.googleSignOut();
  }
}

enum AuthStatus {
  verifyRegister,
  checking,
  authenticated,
  noAuthenticated,
}

class AuthState {
  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = '',
      this.messageRegister = ''});

  AuthState copyWith(
          {AuthStatus? authStatus,
          Users? user,
          String? errorMessage,
          String? messageRegister}) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
        messageRegister: messageRegister ?? this.messageRegister,
      );

  final AuthStatus authStatus;
  final Users? user;
  final String errorMessage;
  final String messageRegister;
}
