import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:local_glovo/models/response/comercio_response.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository_impl.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/pages/comercio_details_page.dart';

class ListadoComercios extends StatefulWidget {
  const ListadoComercios({Key? key}) : super(key: key);

  @override
  State<ListadoComercios> createState() => _ListadoComerciosState();
}

class _ListadoComerciosState extends State<ListadoComercios> {
  late Future<List<Content>> list;
  late ComercioRepository comercioRepository;
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    comercioRepository = ComercioRepositoryImpl();
    list = comercioRepository.listarComercios();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Content>>(
      future: list,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  snapshot.data![0].latitud!, snapshot.data![0].longitud!),
              zoom: 14.0,
            ),
            markers: snapshot.data!.map((comercio) {
              return Marker(
                markerId: MarkerId(comercio.id!),
                position: LatLng(comercio.latitud ?? 0, comercio.longitud ?? 0),
                infoWindow: InfoWindow(
                  title: comercio.name,
                  snippet: comercio.nameDirection,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComercioDetailsPage(
                          comercioID: comercio.id!,
                          carritoRepository: CarritoRepositoryImpl(),
                        ),
                      ),
                    );
                  },
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueViolet),
              );
            }).toSet(),
          );
        }
      },
    );
  }
}
