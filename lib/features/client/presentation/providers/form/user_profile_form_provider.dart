import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../users_provider.dart';

final userFormProvider =
    StateNotifierProvider.family<UserFormNotifier, UserFormState, UserProfile>(
        (ref, userProfile) {
  final createdOrUpdateUser =
      ref.watch(usersProfileProvider.notifier).createOrUpdateUser;
  print('email: ${userProfile.email}');

  return UserFormNotifier(
    onSubmitCallback: createdOrUpdateUser,
    userProfile: userProfile,
  );
});

class UserFormNotifier extends StateNotifier<UserFormState> {
  final Future<bool> Function(
    String idUser,
    String username,
    String email,
    String password,
    String name,
    String lastName,
    String phone,
    double longitude,
    double latitude,
    String postalCode,
    String city,
    String address,
  )? onSubmitCallback;

  UserFormNotifier({
    this.onSubmitCallback,
    required UserProfile userProfile,
  }) : super(
          UserFormState(
            idUser: userProfile.id,
            username: userProfile.username,
            email: userProfile.email,
            password: userProfile.password,
            name: userProfile.name,
            lastName: userProfile.lastName,
            phone: userProfile.phone,
            longitude: userProfile.longitude,
            latitude: userProfile.latitude,
            postalCode: userProfile.postalCode,
            city: userProfile.city,
            address: userProfile.address,
            isFormValid: true,
          ),
        );

  void onUsernameChange(String value) {
    state = state.copyWith(
      username: value,
      isFormValid: true,
    );
  }

  void onEmailChange(String value) {
    state = state.copyWith(
      email: value,
      isFormValid: true,
    );
  }

  void onPasswordChange(String value) {
    state = state.copyWith(
      password: value,
      isFormValid: true,
    );
  }

  void onNameChange(String value) {
    state = state.copyWith(
      name: value,
      isFormValid: true,
    );
  }

  void onLastNameChange(String value) {
    state = state.copyWith(
      lastName: value,
      isFormValid: true,
    );
  }

  void onPhoneChange(String value) {
    state = state.copyWith(
      phone: value,
      isFormValid: true,
    );
  }

  void onLongitudeChange(String value) {
    state = state.copyWith(
      longitude: double.parse(value.isEmpty ? '0.0' : value),
      isFormValid: true,
    );
  }

  void onLatitudeChange(String value) {
    state = state.copyWith(
      latitude: double.parse(value.isEmpty ? '0.0' : value),
      isFormValid: true,
    );
  }

  void onPostalCodeChange(String value) {
    state = state.copyWith(
      postalCode: value,
      isFormValid: true,
    );
  }

  void onCityChange(String value) {
    state = state.copyWith(
      city: value,
      isFormValid: true,
    );
  }

  void onAddressChange(String value) {
    state = state.copyWith(
      address: value,
      isFormValid: true,
    );
  }

  Future<bool> onFormSubmit() async {
    if (!state.isFormValid) return false;
    if (onSubmitCallback == null) return false;
    try {
      return await onSubmitCallback!(
        state.idUser ?? '',
        state.username,
        state.email,
        state.password,
        state.name,
        state.lastName,
        state.phone,
        state.longitude,
        state.latitude,
        state.postalCode,
        state.city,
        state.address,
      );
    } catch (e) {
      return false;
    }
  }
}

class UserFormState {
  final bool isFormValid;
  final String? idUser;
  final String username;
  final String email;
  final String password;
  final String name;
  final String lastName;
  final String phone;
  final double longitude;
  final double latitude;
  final String postalCode;
  final String city;
  final String address;

  UserFormState({
    this.isFormValid = false,
    this.idUser = '',
    this.username = '',
    this.email = '',
    this.password = '',
    this.name = '',
    this.lastName = '',
    this.phone = '',
    this.longitude = 0,
    this.latitude = 0,
    this.postalCode = '',
    this.city = '',
    this.address = '',
  });

  UserFormState copyWith({
    bool? isFormValid,
    String? idUser,
    String? username,
    String? email,
    String? password,
    String? name,
    String? lastName,
    String? phone,
    double? longitude,
    double? latitude,
    String? postalCode,
    String? city,
    String? address,
  }) =>
      UserFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        idUser: idUser ?? this.idUser,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        postalCode: postalCode ?? this.postalCode,
        city: city ?? this.city,
        address: address ?? this.address,
      );
}
