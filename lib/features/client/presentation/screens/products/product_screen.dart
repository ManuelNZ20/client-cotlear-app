import 'package:cotlear_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String productId;
  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product =
        ref.watch(productsProvider.notifier).getProduct(id: productId);
    final titleTheme = Theme.of(context).textTheme.bodyLarge!.copyWith(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        );
    final titlePrice = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 24,
          color: Colors.orange,
          overflow: TextOverflow.ellipsis,
        );
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Detalles del producto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Implementa la lógica del carrito
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(product.img, width: 200, height: 200,
                  loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const CircularProgressIndicator();
                }
              }),
            ),
            const SizedBox(height: 16.0),
            Text(
              product.nameProduct,
              style: titleTheme,
            ),
            const SizedBox(height: 8.0),
            Text(product.brand.toUpperCase(),
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'S/. ${product.productDiscount != null ? (product.price - (product.productDiscount!.discountpercentage * product.price)).toStringAsFixed(2) : product.price.toStringAsFixed(2)}',
                  style: titlePrice,
                ),
                Text(
                  'S/. ${product.price}',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.grey,
                  ),
                ),
                if (product.productDiscount != null)
                  Text('-${product.productDiscount!.discountpercentage * 100}%',
                      style: const TextStyle(fontSize: 16, color: Colors.red)),
              ],
            ),
            if (product.amount > 0)
              const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8.0),
                  Text('Disponible en tienda',
                      style: TextStyle(fontSize: 16, color: Colors.green)),
                ],
              )
            else
              const Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 8.0),
                  Text('No disponible',
                      style: TextStyle(fontSize: 16, color: Colors.red)),
                ],
              ),
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.orange),
                SizedBox(width: 4.0),
                Text('3.5', style: TextStyle(fontSize: 16)),
                SizedBox(width: 4.0),
                Text('(192 revisiones)',
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Descripción',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .2,
              child: SingleChildScrollView(
                child: Text(product.description),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    ref.watch(productsProvider.select((state) => state.products
                            .firstWhere(
                                (product) => product.idProduct == productId)
                            .isFavorite!))
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  onPressed: () {
                    ref
                        .read(productsProvider.notifier)
                        .toggleFavorite(productId);
                  },
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Implementa la lógica de agregar al carrito
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(width: 8.0),
                        Text('AGREGAR AL CARRITO'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
