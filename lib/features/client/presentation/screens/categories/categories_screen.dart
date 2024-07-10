import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/widgets/widgets.dart';
import '../../providers/categories_provider.dart';
import '../../widgets/card_category.dart';

class CategoriesScreen extends StatelessWidget {
  static const String name = 'categories-screen';
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Categorías'),
      ),
      body: const _CategoriesView(),
    );
  }
}

class _CategoriesView extends ConsumerStatefulWidget {
  const _CategoriesView();

  @override
  CategoriesViewState createState() => CategoriesViewState();
}

class CategoriesViewState extends ConsumerState<_CategoriesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoriesProvider.notifier).loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    if (categories.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: GridView.builder(
        itemCount: categories.categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
          mainAxisExtent: 180,
        ),
        itemBuilder: (context, index) {
          final category = categories.categories[index];
          return CardCategory(
            title: category.name,
            imgUrl: category.img,
            location: '/categories/productscategories/${category.idCategory}',
            isActive: category.status,
          );
        },
      ),
    );
  }
}
