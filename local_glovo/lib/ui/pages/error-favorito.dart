import 'package:flutter/material.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/ui/pages/home_page.dart';
import 'package:local_glovo/ui/pages/inicio_page.dart';
import 'package:local_glovo/ui/pages/register_page.dart';
import 'package:local_glovo/ui/pages/ver_favorito_page.dart';

class ErrorFavorito extends StatelessWidget {
  final CarritoRepository carritoRepository;
  final String errorMessage;

  ErrorFavorito({required this.carritoRepository, required this.errorMessage});

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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerFavoritoPage(
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
