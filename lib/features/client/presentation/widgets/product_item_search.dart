import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class ProductItemSearch extends StatelessWidget {
  const ProductItemSearch({
    super.key,
    required this.product,
    required this.onProductSelected,
  });
  final Product product;
  final Function onProductSelected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    final titlePrice = Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 16,
          color: const Color(0xFFD19E63),
          letterSpacing: 1.2,
          overflow: TextOverflow.ellipsis,
        );
    return GestureDetector(
      onTap: () {
        onProductSelected(context, product);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                // Image
                SizedBox(
                  width: size.width * .2,
                  height: 100,
                  child: Image.network(
                    product.img,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }
                      return child;
                    },
                  ),
                ),
                // Description
                SizedBox(
                  width: size.width * .7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        product.nameProduct,
                        style: textStyle.titleSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'S/. ${product.price}',
                            style: titlePrice,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
