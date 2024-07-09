import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:cotlear_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:cotlear_app/shared/shared.dart';

// 3 - Como vamos a construir ese provider - StateNotifierProvider - Como se consume afuera
final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  final googleSignIn = ref.watch(authProvider.notifier).googleSignIn;
  return LoginFormNotifier(
    loginUserCallback: loginUserCallback,
    googleSignIn: googleSignIn,
  );
});

// 2 - Como implementar el notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;
  final Function() googleSignIn;
  LoginFormNotifier({
    required this.loginUserCallback,
    required this.googleSignIn,
  }) : super(LoginFormState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password]),
    );
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email]),
    );
  }

  onViewPassword() {
    print(state.obscureText);
    state = state.copyWith(
      obscureText: !state.obscureText,
    );
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    state = state.copyWith(isPosting: true);
    await loginUserCallback(state.email.value, state.password.value);
    state = state.copyWith(isPosting: false);
  }

  onGoogleSignIn() async {
    await googleSignIn();
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        isValid: Formz.validate([email, password]));
  }
}

// 1 - Crear el estado de este provider - State provider
class LoginFormState {
  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.username = '',
    this.obscureText = true,
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    String? username,
    bool? obscureText,
  }) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        username: username ?? this.username,
        obscureText: obscureText ?? this.obscureText,
      );

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final String username;
  final bool obscureText;
  @override
  String toString() {
    return '''
    LoginFormState
    isPosting: $isPosting
    isFormPosting: $isFormPosted
    isValid: $isValid
    email: $email
    password: $password
    username: $username
''';
  }
}
