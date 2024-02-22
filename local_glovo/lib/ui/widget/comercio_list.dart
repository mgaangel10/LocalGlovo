import 'package:flutter/material.dart';
import 'package:local_glovo/models/response/comercio_response.dart';

class ComercioWidget extends StatelessWidget {
  final Content contentElement;
  const ComercioWidget({super.key, required this.contentElement});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      width: 130, // Ancho del card
      height: 211,
      child: Card(
        color: Color.fromARGB(255, 255, 255, 255), // Color del card
        shadowColor: Color.fromARGB(255, 0, 0, 0), // Color de la sombra
        elevation: 10, // Elevación para dar efecto de sombra
        shape: RoundedRectangleBorder(
          // Forma del card
          borderRadius: BorderRadius.circular(25), // Borde redondeado
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Center(
                child: Image(
                  image: NetworkImage(contentElement.imagen!),
                  // Altura de la imagen
                  width: double.infinity, // Ancho de la imagen
                  fit: BoxFit
                      .cover, // Para que la imagen cubra todo el espacio disponible
                ),
              ),
              SizedBox(height: 10), // Espacio entre la imagen y el nombre
              Text(
                contentElement.name!,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold), // Estilo del texto
              ),
              SizedBox(height: 10), // Espacio entre el nombre y la calificación
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // Fila para la calificación y el ícono de estrella
                    children: [
                      Icon(Icons.star,
                          color: Colors.yellow), // Ícono de estrella
                      SizedBox(
                          width:
                              5), // Espacio entre la estrella y la calificación
                      Text(contentElement.rating.toString()),
                    ],
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
