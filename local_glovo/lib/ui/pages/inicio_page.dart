import 'package:flutter/material.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/ui/pages/User_page.dart';
import 'package:local_glovo/ui/pages/home_page.dart';
import 'package:local_glovo/ui/pages/ver_carrito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InicioPage extends StatefulWidget {
  final CarritoRepository carritoRepository;

  const InicioPage({super.key, required this.carritoRepository});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions(CarritoRepository carritoRepository) => [
        HomePage(carritoRepository: carritoRepository),
        VerCarrito(carritoRepository: carritoRepository),
        UserPage(),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions(widget.carritoRepository).elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: Colors.black,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded, color: Colors.white),
              label: 'Carrito',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.white),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
