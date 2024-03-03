import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_details_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/pages/carrito_page.dart';
import 'package:local_glovo/ui/pages/comercio_details_page.dart';
import 'package:local_glovo/ui/pages/home_page.dart';
import 'package:local_glovo/ui/widget/comercio_list.dart';
import 'package:local_glovo/ui/widget/geocalizacion.dart';

class MetodoPagoPage extends StatefulWidget {
  final CarritoRepository carritoRepository;

  const MetodoPagoPage({Key? key, required this.carritoRepository})
      : super(key: key);

  @override
  State<MetodoPagoPage> createState() => _MetodoPagoPageState();
}

class _MetodoPagoPageState extends State<MetodoPagoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Elige un metodo de pago"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                          carritoRepository: widget.carritoRepository)),
                );
              },
              child: const ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                title: Text(
                  'Visa',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(Icons.account_balance_wallet_sharp,
                    size: 40), // Icono a la derecha
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                          carritoRepository: widget.carritoRepository)),
                );
              },
              child: const ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                title: Text(
                  'Paypal',
                  style: TextStyle(fontSize: 20),
                ),
                trailing:
                    Icon(Icons.paypal_rounded, size: 40), // Icono a la derecha
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                          carritoRepository: widget.carritoRepository)),
                );
              },
              child: const ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                title: Text(
                  'Tarjeta Credito',
                  style: TextStyle(fontSize: 20),
                ),
                trailing:
                    Icon(Icons.credit_card, size: 40), // Icono a la derecha
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                          carritoRepository: widget.carritoRepository)),
                );
              },
              child: const ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                title: Text(
                  'Efectivo',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(Icons.attach_money_rounded,
                    size: 40), // Icono a la derecha
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
