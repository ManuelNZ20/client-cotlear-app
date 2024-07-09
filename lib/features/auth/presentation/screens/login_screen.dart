import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:cotlear_app/features/auth/presentation/providers/providers.dart';
import '../../../../shared/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height - 100,
                  child: const _LoginForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    final titleTextTheme = Theme.of(context).textTheme.bodyMedium;
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        showSnackbar(context, next.errorMessage);
      }
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.network(
            width: 300,
            height: 300,
            'https://www.ferreteriarobertocotlear.tech/public/img/logo.png',
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errorMessage:
                loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Contraseña',
            obscureText: loginForm.obscureText,
            onPressed: ref.read(loginFormProvider.notifier).onViewPassword,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Iniciar Sesión',
              onPressed: loginForm.isPosting
                  ? null
                  : ref.read(loginFormProvider.notifier).onFormSubmit,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continuar con',
                style: titleTextTheme,
              ),
              const SizedBox(width: 10),
              const FaIcon(FontAwesomeIcons.facebook),
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿No tienes cuenta?'),
              TextButton(
                onPressed: () => context.push('/register'),
                child: const Text('Crea una aquí'),
              )
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
