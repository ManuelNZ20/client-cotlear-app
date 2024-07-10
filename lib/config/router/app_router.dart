import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cotlear_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:cotlear_app/features/auth/presentation/screens/screens.dart';
import '../../features/client/presentation/screens/screens.dart';
import '../../features/client/presentation/views/views.dart';
import 'app_router_notifier.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable:
        goRouterNotifier, //Cuando cambie evalua el redirect, esta pendiente del estado de autenticación, cuando la autenticación cambia vuelve a evaluar el redirect, cuando no esta autenticado retira al usuario.
    routes: [
      // Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      // Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return HomeScreen(childView: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeView(),
            routes: [
              // PRODUCT
              GoRoute(
                path: 'product/:idProduct',
                builder: (context, state) {
                  final idProduct = state.pathParameters['idProduct'];
                  return ProductDetailScreen(
                    productId: idProduct!,
                  );
                },
              ),
              GoRoute(
                path: 'products-all',
                builder: (context, state) {
                  return const ProductsAllScreen();
                },
              ),
              // Categories
              GoRoute(
                path: 'categories',
                builder: (context, state) => const CategoriesScreen(),
                routes: [
                  GoRoute(
                    path: 'productscategories/:idCategory',
                    builder: (context, state) {
                      final idCategory = state.pathParameters['idCategory'];
                      return ProductsByIdCategoryScreen(
                        categoryId: idCategory!,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/orders',
            builder: (context, state) => const OrdersView(),
          ),

          GoRoute(
            path: '/cart',
            builder: (context, state) => const CartView(),
          ),
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoritesView(),
          ),
          // CATEGORIES

          GoRoute(
            path: '/user',
            builder: (context, state) => const UserScreen(),
          ),
        ],
      )
    ],
    redirect: (context, state) {
      final authStatus = goRouterNotifier.authStatus;
      final isGoingTo = state.matchedLocation;
      // print('Location: ${state.matchedLocation} Status: $authStatus');
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.noAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }
      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/';
        }
      }

      // if(user.isAdmin) ruta admin
      return null;
    },
  );
});
