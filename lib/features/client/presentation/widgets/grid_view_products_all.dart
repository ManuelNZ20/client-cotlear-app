import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import '../providers/products_provider.dart';
import 'card_product.dart';

class GridViewProductsAll extends ConsumerWidget {
  const GridViewProductsAll({
    super.key,
    required this.products,
    this.isFavorite = false,
    this.isPromotion = false,
    this.offPercentage = const [],
  });

  final List<Product> products;
  final bool? isFavorite;
  final bool? isPromotion;
  final List<double>? offPercentage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 300,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return isPromotion!
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
                isPromocion: isPromotion!,
                priceDiscountApplied: product.price,
                offPercentage: product.productDiscount!.discountpercentage,
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
                isPromocion: isPromotion!,
              );
      },
    );
  }
}
