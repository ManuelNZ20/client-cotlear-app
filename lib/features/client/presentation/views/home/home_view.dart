import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/horizontal_products_listview.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Column(
                children: [
                  const CustomSlideShow(),
                  HorizontalProductsListView(
                    products: products.products
                        .where((element) => element.productDiscount != null)
                        .toList(),
                    title: 'Populares',
                    isPromotion: false,
                  ),
                  HorizontalProductsListView(
                    products: products.products,
                    title: 'Oferta de productos',
                    isPromotion: true,
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
