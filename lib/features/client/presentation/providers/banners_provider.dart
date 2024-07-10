import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'repository/banner_repository_provider.dart';
import '../../domain/domain.dart';

final bannersProvider =
    StateNotifierProvider<BannersCardNotifier, BannersCardState>((ref) {
  final bannerCardRepository = ref.watch(bannerRepositoryProvider);

  return BannersCardNotifier(bannerCardRepository: bannerCardRepository);
});

class BannersCardNotifier extends StateNotifier<BannersCardState> {
  final BannerCardRepository bannerCardRepository;
  BannersCardNotifier({
    required this.bannerCardRepository,
  }) : super(BannersCardState()) {
    loadBanners();
  }
  Stream<List<BannerCard>> getBannersStream() {
    final banners = bannerCardRepository.getBannersStream();
    return banners;
  }

  Future<void> loadBanners() async {
    try {
      state = state.copyWith(bannersCard: []);
      if (state.isLoading) return;
      state = state.copyWith(isLoading: true);
      final banners = await bannerCardRepository.getBanners();
      if (banners.isEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }
      state = state.copyWith(
        isLoading: false,
        bannersCard: banners,
      );
    } catch (e) {
      print('Error: $e');
      state = state.copyWith(isLoading: false);
    }
  }
}

class BannersCardState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<BannerCard> bannersCard;

  BannersCardState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.bannersCard = const []});

  BannersCardState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<BannerCard>? bannersCard,
  }) =>
      BannersCardState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        bannersCard: bannersCard ?? this.bannersCard,
      );
}
