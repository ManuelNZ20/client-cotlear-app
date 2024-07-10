import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);

  final categoryRepository = CategoryRepositoryImpl(
    supabaseClient: supabaseClient,
    categoryDataSource: CategoryDatasourceImpl(),
  );
  return categoryRepository;
});
