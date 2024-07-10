import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

final productDiscountRepositoryProvider =
    Provider<ProductDiscountRepository>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  final productDiscountRepository = ProductDiscountRepositoryImpl(
    supabaseClient: supabaseClient,
    productDiscountDatasource: ProductDiscountDataSourceImpl(),
  );

  return productDiscountRepository;
});
