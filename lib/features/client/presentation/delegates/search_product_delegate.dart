import 'dart:async';

import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../widgets/widgets.dart';

typedef SearchProductsCallback = Future<List<Product>> Function(
    String textSearch);

class SearchProductDelegate extends SearchDelegate<Product?> {
  final SearchProductsCallback searchProductsCallback;
  List<Product> initialProducts;
  StreamController<List<Product>> debouncedProduct =
      StreamController.broadcast();
  Timer? _debounceTimer;
  SearchProductDelegate({
    required this.searchProductsCallback,
    required this.initialProducts,
  }) : super(
          searchFieldLabel: 'Buscar productos',
        );

  void clearStreams() {
    debouncedProduct.close();
  }

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debouncedProduct.add([]);
        return;
      }

      final products = await searchProductsCallback(query);
      initialProducts = products;
      debouncedProduct.add(products);
    });
  }

  Widget buildResutlsAndSuggestions() {
    return StreamBuilder(
      initialData: initialProducts,
      stream: debouncedProduct.stream,
      builder: (context, snapshot) {
        final products = snapshot.data ?? [];
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductItemSearch(
              product: product,
              onProductSelected: (context, product) {
                clearStreams();
                close(context, product);
              },
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear_outlined),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResutlsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResutlsAndSuggestions();
  }
}
