import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/widgets/widgets.dart';
import '../../../../auth/presentation/providers/providers.dart';
import '../../../domain/domain.dart';
import '../../providers/form/user_profile_form_provider.dart';
import '../../providers/user_provider.dart';

class UserScreen extends ConsumerWidget {
  static const String name = 'user-screen';
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final user = ref.watch(userProvider(auth.user!.email));
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Información del usuario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: user.isLoading
          ? const FullScreenLoader()
          : SafeArea(
              child: SingleChildScrollView(
                child: _UserViewInformation(
                  userProfile: user.userProfile!,
                ),
              ),
            ),
    );
  }
}

class _UserViewInformation extends ConsumerWidget {
  final UserProfile userProfile;
  const _UserViewInformation({
    required this.userProfile,
  });

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Datos Actualizado')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileForm = ref.watch(userFormProvider(userProfile));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.network(
            width: 150,
            height: 150,
            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Nombre de usuario',
            initialValue: userProfileForm.username,
            onChanged: ref
                .read(userFormProvider(userProfile).notifier)
                .onUsernameChange,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Nombres',
            initialValue: userProfileForm.name,
            onChanged:
                ref.read(userFormProvider(userProfile).notifier).onNameChange,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Apellidos',
            initialValue: userProfileForm.lastName,
            onChanged: ref
                .read(userFormProvider(userProfile).notifier)
                .onLastNameChange,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Correo electronico',
            initialValue: userProfileForm.email,
            onChanged:
                ref.read(userFormProvider(userProfile).notifier).onEmailChange,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Telefono',
            keyboardType: TextInputType.phone,
            initialValue: userProfileForm.phone,
            onChanged:
                ref.read(userFormProvider(userProfile).notifier).onPhoneChange,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Codigo postal',
            initialValue: userProfileForm.postalCode,
            onChanged: ref
                .read(userFormProvider(userProfile).notifier)
                .onPostalCodeChange,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Dirección',
            initialValue: userProfileForm.address,
            onChanged: ref
                .read(userFormProvider(userProfile).notifier)
                .onAddressChange,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Ciudad',
            initialValue: userProfileForm.city,
            onChanged:
                ref.read(userFormProvider(userProfile).notifier).onCityChange,
          ),
          const SizedBox(height: 30),
          FilledButton.icon(
            onPressed: () {
              ref
                  .read(userFormProvider(userProfile).notifier)
                  .onFormSubmit()
                  .then(
                (value) {
                  print('Value $value');
                  if (!value) return;
                  showSnackbar(context);
                },
              );
            },
            icon: const Icon(Icons.save_outlined),
            label: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
