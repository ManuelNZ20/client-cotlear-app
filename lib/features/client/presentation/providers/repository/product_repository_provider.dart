import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  final productRepository = ProductRepositoryImpl(
    supabaseClient: supabaseClient,
    productDataSource: ProductDatasourceImpl(),
  );
  return productRepository;
});
