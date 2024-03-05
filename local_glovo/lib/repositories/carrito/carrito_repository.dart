import 'package:local_glovo/models/response/add_producto_to_cart/add_producto_to_cart.dart';

abstract class CarritoRepository {
  Future<AddProductoToCart> addAlCarrito(String productoId);
  Future<void> deleteProducto(String carritoId, String productoId);
  Future<AddProductoToCart> terminarCarrito(String carritoId);
  Future<AddProductoToCart> verCarritoid();
}
