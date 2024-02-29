import 'package:local_glovo/models/response/add_producto_to_cart/add_producto_to_cart.dart';

abstract class CarritoRepository {
  Future<AddProductoToCart> addAlCarrito(String usuarioId, String productoId);
}
