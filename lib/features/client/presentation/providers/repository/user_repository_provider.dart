import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

final userProfileRepositoryProvider = Provider<UserRepository>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  final userRepository = UserRepositoryImpl(
    supabaseClient: supabaseClient,
    userDatasource: UserDatasourceImpl(),
  );
  return userRepository;
});
