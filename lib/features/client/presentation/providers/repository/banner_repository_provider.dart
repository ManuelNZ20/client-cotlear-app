import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

// Banner
final bannerRepositoryProvider = Provider<BannerCardRepository>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);

  final bannerCardRepository = BannerCardRepositoryImpl(
    supabaseClient: supabaseClient,
    bannerDataSource: BannerCardDatasourceImpl(),
  );
  return bannerCardRepository;
});
