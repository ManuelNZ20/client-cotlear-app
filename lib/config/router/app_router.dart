import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cotlear_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:cotlear_app/features/auth/presentation/screens/screens.dart';
import '../../features/client/screens/screens.dart';
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
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      // database
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
