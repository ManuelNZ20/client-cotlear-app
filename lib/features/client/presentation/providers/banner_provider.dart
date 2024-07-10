import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'repository/banner_repository_provider.dart';
import '../../domain/domain.dart';

final bannerProvider = StateNotifierProvider.autoDispose
    .family<BannerNotifier, BannerState, String>((ref, idBanner) {
  final bannerCardRepository = ref.watch(bannerRepositoryProvider);
  return BannerNotifier(
    bannerCardRepository: bannerCardRepository,
    idBanner: idBanner,
  );
});

class BannerNotifier extends StateNotifier<BannerState> {
  final BannerCardRepository bannerCardRepository;
  BannerNotifier({
    required this.bannerCardRepository,
    required String idBanner,
  }) : super(BannerState(id: idBanner)) {
    loadBanner();
  }

  BannerCard newEmptyBannerCard() {
    return BannerCard(
      idBanner: 'new',
      title: '',
      subTitle: '',
      imgUrl:
          'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
      createdAt: DateTime.now(),
      expiredAt: DateTime(2024, DateTime.december, 10, 11, 59),
      titleLink: '',
      isActive: false,
      linkScreen: '/products/productspopular/',
    );
  }

  Future<void> loadBanner() async {
    try {
      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          bannerCard: newEmptyBannerCard(),
        );
        return;
      }
      final banner = await bannerCardRepository.getBannerById(id: state.id);
      state = state.copyWith(
        isLoading: false,
        bannerCard: banner,
      );
    } catch (e) {
      throw (e.toString());
    }
  }
}

class BannerState {
  final String id;
  final BannerCard? bannerCard;
  final bool isLoading;
  final bool isSaving;

  BannerState({
    required this.id,
    this.bannerCard,
    this.isLoading = true,
    this.isSaving = false,
  });

  BannerState copyWith({
    String? id,
    BannerCard? bannerCard,
    bool? isLoading,
    bool? isSaving,
  }) =>
      BannerState(
        id: id ?? this.id,
        bannerCard: bannerCard ?? this.bannerCard,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
