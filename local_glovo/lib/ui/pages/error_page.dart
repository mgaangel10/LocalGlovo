import 'package:flutter/material.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/ui/pages/home_page.dart';
import 'package:local_glovo/ui/pages/inicio_page.dart';

class ErrorPage extends StatelessWidget {
  final CarritoRepository carritoRepository;
  final String errorMessage;

  ErrorPage({required this.carritoRepository, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                errorMessage,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navega a la página HomePage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InicioPage(
                      carritoRepository: carritoRepository,
                    ),
                  ),
                );
              },
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
