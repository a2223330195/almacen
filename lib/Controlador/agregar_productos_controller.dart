import 'package:hive_flutter/hive_flutter.dart';
import 'package:almacen/Controlador/ver_productos_controller.dart';

class AgregarProductosController {
  final verProductosController = VerProductosController();

  void agregarProducto({
    required String id,
    required String nombre,
    required String precio,
  }) {
    //1.- validar mis datos (entrada)
    if (id.isEmpty || nombre.isEmpty || precio.isEmpty) {
      throw Exception('Por favor proporciona todos los campos requeridos.');
    }

    //2.- guardar en la base de datos
    var productos = Hive.box('productos');
    productos.put(
      id,
      {
        'id': id,
        'nombre': nombre,
        'precio': precio,
      },
    );

    // Actualizar la lista de productos
    verProductosController.actualizarProductos();
  }

  void eliminarProducto(String idProducto) {
    // Cambio de String a int
    var productos = Hive.box('productos');
    productos.delete(idProducto);

    // Verificar la eliminación
    var producto = productos.get(idProducto);
    if (producto == null) {
      print('Producto eliminado correctamente');
    } else {
      print('Error al eliminar el producto');
    }

    // Actualizar la lista de productos
    verProductosController.actualizarProductos();
  }
}
