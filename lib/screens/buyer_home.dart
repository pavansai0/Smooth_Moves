import 'package:flutter/material.dart';
import 'package:smooth_moves/screens/home_page.dart';
import 'package:smooth_moves/screens/cart_page.dart';
import 'package:smooth_moves/screens/profile_page.dart';

class BuyersHomeScreen extends StatefulWidget {
  const BuyersHomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BuyersHomeScreenState createState() => _BuyersHomeScreenState();
}

class _BuyersHomeScreenState extends State<BuyersHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const ProfilePage(),
  ];

  void _onItemClicked(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyer Home'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemClicked,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
