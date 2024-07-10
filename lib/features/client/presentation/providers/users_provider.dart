import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'repository/repositories_provider.dart';

final usersProfileProvider =
    StateNotifierProvider<UsersNotifier, UsersProfileState>((ref) {
  final userRepository = ref.watch(userProfileRepositoryProvider);
  return UsersNotifier(
    userRepository: userRepository,
  );
});

class UsersNotifier extends StateNotifier<UsersProfileState> {
  final UserRepository userRepository;

  UsersNotifier({required this.userRepository}) : super(UsersProfileState()) {
    loadUsersProfile();
  }

  Future<void> loadUsersProfile() async {
    try {
      state = state.copyWith(
        usersProfile: [],
      );
      if (state.isLoading) return;
      state = state.copyWith(isLoading: true);
      final usersProfile = await userRepository.getUsers();
      if (usersProfile.isEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }
      state = state.copyWith(
        isLoading: false,
        usersProfile: usersProfile,
      );
    } catch (e) {
      print('Error: $e');
      state = state.copyWith(
        isLoading: false,
      );
    }
  }

  Future<bool> createOrUpdateUser(
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
  ) async {
    try {
      // Actualizar datos del usuario
      final user = await userRepository.updateUser(
        id: idUser,
        email: email,
        password: password,
        username: username,
        createdAt: DateTime.now(),
        name: name,
        lastName: lastName,
        phone: phone,
        longitude: longitude,
        latitude: latitude,
        postalCode: postalCode,
        city: city,
        address: address,
      );
      state = state.copyWith(
        usersProfile:
            state.usersProfile.map((e) => (e.id == idUser ? user : e)).toList(),
      );
      return true;
    } catch (e) {
      print('Error = $e');
      return false;
    }
  }
}

class UsersProfileState {
  final List<UserProfile> usersProfile;
  final bool isLoading;
  final bool hasError;

  UsersProfileState({
    this.usersProfile = const [],
    this.isLoading = false,
    this.hasError = false,
  });

  UsersProfileState copyWith({
    List<UserProfile>? usersProfile,
    bool? isLoading,
    bool? hasError,
  }) {
    return UsersProfileState(
      usersProfile: usersProfile ?? this.usersProfile,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
