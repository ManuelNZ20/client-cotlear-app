import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/providers.dart';
import '../../domain/domain.dart';
import '../delegates/search_product_delegate.dart';
import '../providers/providers.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final user = ref.watch(userProvider(auth.user!.email));
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              user.isLoading
                  ? const CircularProgressIndicator()
                  : user.userProfile != null
                      ? _TextUserProfile(userProfile: user.userProfile!)
                      : const Text('Error loading user profile'),
              const Spacer(),
              IconButton(
                onPressed: () {
                  final searchedProducts = ref.read(searchProductsProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  showSearch<Product?>(
                    context: context,
                    query: searchQuery,
                    delegate: SearchProductDelegate(
                      initialProducts: searchedProducts,
                      searchProductsCallback: ref
                          .read(searchProductsProvider.notifier)
                          .searchProductByQuery,
                    ),
                  ).then((product) {
                    if (product == null) return;
                    context.push('/product/${product.idProduct}');
                  });
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  context.push('/categories');
                },
                icon: const Icon(Icons.category_rounded),
              ),
              IconButton(
                onPressed: () {
                  context.push('/user');
                },
                icon: const Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextUserProfile extends ConsumerWidget {
  const _TextUserProfile({
    required this.userProfile,
  });

  final UserProfile userProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileForm = ref.watch(userFormProvider(userProfile));
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return Text(
      'Hola, ${userProfileForm.name}',
      style: titleStyle,
    );
  }
}
