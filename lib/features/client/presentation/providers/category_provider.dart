import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'repository/repositories_provider.dart';

final categoryProvider = StateNotifierProvider.autoDispose
    .family<CategoryNotifier, CategoryState, String>((ref, idCategory) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return CategoryNotifier(
    categoryRepository: categoryRepository,
    idCategory: idCategory,
  );
});

class CategoryNotifier extends StateNotifier<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryNotifier({
    required this.categoryRepository,
    required String idCategory,
  }) : super(CategoryState(
          id: idCategory,
        )) {
    loadCategory();
  }
  CategoryCard newEmptyCategory() {
    return CategoryCard(
      idCategory: 'new',
      name: '',
      status: false,
      img:
          'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png',
    );
  }

  Future<void> loadCategory() async {
    try {
      if (state.id == 'new') {
        state = state.copyWith(
          isLoading: false,
          categoryCard: newEmptyCategory(),
        );
        return;
      }
      final category = await categoryRepository.getCategoryById(id: state.id);
      state = state.copyWith(
        isLoading: false,
        categoryCard: category,
      );
    } catch (e) {
      throw (e.toString());
    }
  }
}

class CategoryState {
  final String id;
  final CategoryCard? categoryCard;
  final bool isLoading;
  final bool isSaving;

  CategoryState({
    required this.id,
    this.categoryCard,
    this.isLoading = true,
    this.isSaving = false,
  });

  CategoryState copyWith({
    String? id,
    CategoryCard? categoryCard,
    bool? isLoading,
    bool? isSaving,
  }) =>
      CategoryState(
        id: id ?? this.id,
        categoryCard: categoryCard ?? this.categoryCard,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
