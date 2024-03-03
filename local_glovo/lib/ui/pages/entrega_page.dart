import 'package:flutter/material.dart';

class EntregaPage extends StatelessWidget {
  const EntregaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¿Cómo quieres la entrega?'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                leading: SizedBox(width: 10), // Margen a la izquierda del icono
                title: Text(
                  'En tienda',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(Icons.store, size: 40), // Icono a la derecha
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 5,
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                leading: SizedBox(width: 10), // Margen a la izquierda del icono
                title: Text(
                  'A domicilio',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(Icons.motorcycle_sharp,
                    size: 40), // Icono a la derecha
              ),
            ),
          ],
        ),
      ),
    );
  }
}
