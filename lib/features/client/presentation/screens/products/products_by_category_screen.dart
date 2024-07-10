import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/shared.dart';
import '../../providers/providers.dart';
import '../../widgets/grid_view_products_all.dart';

class ProductsByIdCategoryScreen extends ConsumerWidget {
  static const name = 'products-all-screen';
  const ProductsByIdCategoryScreen({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleNumber = Theme.of(context).textTheme.titleLarge!.copyWith();
    final int idCategory = int.parse(categoryId);
    final category = ref.watch(categoryProvider(categoryId));
    final products = ref
        .watch(productsProvider.notifier)
        .getProductsByIdCategory(idCategory: idCategory);
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: category.isLoading
            ? const Text('Cargando...')
            : Text(category.categoryCard!.name),
        actions: [
          Text(
            '${products.length}',
            style: titleNumber,
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.category_rounded,
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 2,
            vertical: 2,
          ),
          child: GridViewProductsAll(
            products: products,
            isPromotion: true,
          )),
    );
  }
}
