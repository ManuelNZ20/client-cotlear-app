import 'package:cotlear_app/features/client/presentation/providers/providers.dart';
import 'package:cotlear_app/features/client/presentation/widgets/card_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/domain.dart';

class HorizontalProductsListView extends ConsumerWidget {
  const HorizontalProductsListView({
    super.key,
    required this.products,
    required this.title,
    required this.isPromotion,
  });
  final List<Product> products;
  final String title;
  final bool isPromotion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          _Title(title: title),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  width: 190,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: product.productDiscount != null
                      ? CardProduct(
                          location: '/product/${product.idProduct}',
                          name: product.nameProduct,
                          brand: product.brand,
                          priceOriginal: product.price -
                              (product.price *
                                  product.productDiscount!.discountpercentage),
                          img: product.img,
                          onPressedFavorite: () {
                            ref
                                .read(productsProvider.notifier)
                                .toggleFavorite(product.idProduct);
                          },
                          isFavorite: product.isFavorite!,
                          isPromocion: isPromotion,
                          priceDiscountApplied: product.price,
                          offPercentage:
                              product.productDiscount!.discountpercentage,
                        )
                      : CardProduct(
                          location: '/product/${product.idProduct}',
                          name: product.nameProduct,
                          brand: product.brand,
                          priceOriginal: product.price,
                          img: product.img,
                          isFavorite: product.isFavorite!,
                          onPressedFavorite: () {
                            ref
                                .read(productsProvider.notifier)
                                .toggleFavorite(product.idProduct);
                          },
                          isPromocion: isPromotion,
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(title),
          const Spacer(),
          TextButton(
            onPressed: () => context.push('/products-all'),
            child: const Text('Ver Todo'),
          ),
        ],
      ),
    );
  }
}
