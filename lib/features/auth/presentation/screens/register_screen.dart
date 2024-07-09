import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:cotlear_app/features/auth/presentation/providers/providers.dart';
import 'package:cotlear_app/shared/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                if (!context.canPop()) return;
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            title: Column(
              children: [
                Text(
                  'Crear cuenta',
                  style: textTheme.titleMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Completa los campos necesarios',
                  style: textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height, // 80 los dos sizebox y 100 el ícono
                  width: double.infinity,
                  child: const _RegisterForm(),
                )
              ],
            ),
          )),
    );
  }
}

class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        showSnackbar(context, next.errorMessage);
      }
      if (next.messageRegister.isNotEmpty) {
        showSnackbar(context, next.messageRegister);
      }
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 30),
          CustomTextField(
            label: 'Nombre de usuario',
            keyboardType: TextInputType.name,
            onChanged: ref.read(registerFormProvider.notifier).onUserNameChange,
          ),
          const SizedBox(height: 30),
          CustomTextField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.email.errorMessage
                : null,
          ),
          const SizedBox(height: 30),
          CustomTextField(
            label: 'Contraseña',
            obscureText: registerForm.obscureTextPassword,
            onPressed: ref.read(registerFormProvider.notifier).onViewPassword,
            onChanged: ref.read(registerFormProvider.notifier).onPasswordChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.password.errorMessage
                : registerForm.statePassword == StatePassword.neutral
                    ? null
                    : registerForm.statePassword == StatePassword.notVerify
                        ? 'Las contraseñas no coinciden'
                        : null,
          ),
          const SizedBox(height: 30),
          CustomTextField(
            label: 'Repita la contraseña',
            obscureText: registerForm.obscureTextRepeatPassword,
            onPressed:
                ref.read(registerFormProvider.notifier).onViewRepeatPassword,
            onChanged:
                ref.read(registerFormProvider.notifier).onPasswordRepeatChange,
            errorMessage: registerForm.isFormPosted
                ? registerForm.repeatPassword.errorMessage
                : registerForm.statePassword == StatePassword.neutral
                    ? null
                    : registerForm.statePassword == StatePassword.notVerify
                        ? 'Las contraseñas no coinciden'
                        : null,
          ),
          const SizedBox(height: 30),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Crear',
                onPressed: ref.read(registerFormProvider.notifier).onFormSubmit,
              )),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Continuar con'),
              const SizedBox(width: 10),
              const FaIcon(
                FontAwesomeIcons.facebook,
                semanticLabel: "Facebook SignIn",
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: ref.read(loginFormProvider.notifier).onGoogleSignIn,
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  semanticLabel: "Google SignIn",
                ),
              ),
            ],
          ),
          const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Ya tienes cuenta?'),
              TextButton(
                  onPressed: () {
                    if (context.canPop()) {
                      return context.pop();
                    }
                    context.go('/login');
                  },
                  child: const Text('Ingresa aquí'))
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
