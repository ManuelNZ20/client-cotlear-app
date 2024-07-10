import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../shared/shared.dart';
import '../../providers/providers.dart';
import '../../widgets/grid_view_products_all.dart';

class ProductsAllScreen extends ConsumerWidget {
  static const name = 'products-all-screen';
  const ProductsAllScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleNumber = Theme.of(context).textTheme.titleLarge!.copyWith();

    final products = ref.watch(productsProvider.notifier).getProducts();
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Productos'),
        actions: [
          Text(
            '${products.length}',
            style: titleNumber,
          ),
          const SizedBox(width: 5),
          const FaIcon(
            FontAwesomeIcons.store,
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
            isPromotion: false,
          )),
    );
  }
}
