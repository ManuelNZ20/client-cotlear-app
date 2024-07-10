import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../repository/repositories_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchProductsProvider =
    StateNotifierProvider<SearchProductNotifier, List<Product>>((ref) {
  final productRepository = ref.read(productRepositoryProvider);
  return SearchProductNotifier(
    searchProduct: productRepository.searchProducts,
    ref: ref,
  );
});

typedef SearchProductCallback = Future<List<Product>> Function(String query);

class SearchProductNotifier extends StateNotifier<List<Product>> {
  final SearchProductCallback searchProduct;
  final Ref ref;
  SearchProductNotifier({
    required this.searchProduct,
    required this.ref,
  }) : super([]);

  Future<List<Product>> searchProductByQuery(String query) async {
    final List<Product> products = await searchProduct(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = products;
    return products;
  }
}
