import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    switch (location) {
      case '/':
        return 0;
      case '/orders':
        return 1;
      case '/cart':
        return 2;
      case '/favorites':
        return 3;
      default:
        return 0;
    }
  }

  void nItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;

      case 1:
        context.go('/orders');
        break;

      case 2:
        context.go('/cart');
        break;

      case 3:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: getCurrentIndex(context),
      iconSize: 20,
      selectedFontSize: 12,
      unselectedFontSize: 10,
      fixedColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.white,
      unselectedItemColor: Theme.of(context).primaryColor,
      onTap: (value) => nItemTapped(context, value),
      // showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: 'Ordenes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Carro',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_rounded),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
