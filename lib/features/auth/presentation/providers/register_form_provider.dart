import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:cotlear_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:cotlear_app/shared/infrastructure/inputs/inputs.dart';

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).register;
  return RegisterFormNotifier(
    registerUserCallback: registerUserCallback,
  );
});

// 2 - Como implementar el notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallback;
  RegisterFormNotifier({required this.registerUserCallback})
      : super(RegisterFormState());

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
    state = state.copyWith(obscureTextPassword: !state.obscureTextPassword);
  }

  onViewRepeatPassword() {
    state = state.copyWith(
        obscureTextRepeatPassword: !state.obscureTextRepeatPassword);
  }

  onPasswordRepeatChange(String value) {
    final repeatPassword = Password.dirty(value);
    state = state.copyWith(
      repeatPassword: repeatPassword,
      isValid: Formz.validate([state.password, state.email, repeatPassword]),
    );
  }

  onUserNameChange(String value) {
    final newUserName = value;
    state = state.copyWith(
      username: newUserName,
      isValid: true,
    );
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    await registerUserCallback(
      state.email.value,
      state.password.value,
      state.username,
    );
    state = state.copyWith(
      isCheckAccount: true,
      statePassword: StatePassword.verify,
    );
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final repeatPassword = Password.dirty(state.repeatPassword.value);
    if (state.password.value != state.repeatPassword.value) {
      state = state.copyWith(
        statePassword: StatePassword.notVerify,
        isValid: false,
      );
      return;
    }
    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        repeatPassword: repeatPassword,
        isValid: Formz.validate([email, password, repeatPassword]));
  }
}

enum StatePassword { neutral, verify, notVerify }

// 1 - Crear el estado de este provider - State provider
class RegisterFormState {
  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.repeatPassword = const Password.pure(),
    this.username = '',
    this.isCheckAccount = false,
    this.statePassword = StatePassword.neutral,
    this.obscureTextPassword = true,
    this.obscureTextRepeatPassword = true,
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    Password? repeatPassword,
    String? username,
    bool? isCheckAccount,
    StatePassword? statePassword,
    bool? obscureTextPassword,
    bool? obscureTextRepeatPassword,
  }) =>
      RegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        repeatPassword: repeatPassword ?? this.repeatPassword,
        username: username ?? this.username,
        isCheckAccount: isCheckAccount ?? this.isCheckAccount,
        statePassword: statePassword ?? this.statePassword,
        obscureTextPassword: obscureTextPassword ?? this.obscureTextPassword,
        obscureTextRepeatPassword:
            obscureTextRepeatPassword ?? this.obscureTextRepeatPassword,
      );

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final Password repeatPassword;
  final String username;
  final bool isCheckAccount;
  final StatePassword statePassword;
  final bool obscureTextPassword;
  final bool obscureTextRepeatPassword;

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
