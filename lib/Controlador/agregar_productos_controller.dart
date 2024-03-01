import 'package:logging/logging.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:almacen/Controlador/ver_productos_controller.dart';

class AgregarProductosController {
  final verProductosController = VerProductosController();
  final Logger logger = Logger('AgregarProductosController');

  void agregarProducto({
    required String id,
    required String nombre,
    required String precio,
    required int stock,
  }) {
    if (id.isEmpty || nombre.isEmpty || precio.isEmpty) {
      throw Exception('Por favor proporciona todos los campos requeridos.');
    }

    var productos = Hive.box('productos');
    productos.put(
      id,
      {
        'id': id,
        'nombre': nombre,
        'precio': precio,
        'stock': stock,
      },
    );

    verProductosController.actualizarProductos();
  }

  void eliminarProducto(String idProducto) {
    var productos = Hive.box('productos');
    productos.delete(idProducto);

    var producto = productos.get(idProducto);
    if (producto == null) {
      logger.info('Producto eliminado correctamente');
    } else {
      logger.severe('Error al eliminar el producto');
    }

    verProductosController.actualizarProductos();
  }

  void modificarProducto({
    required String id,
    required String nuevoNombre,
    required String nuevoPrecio,
    required int nuevoStock,
  }) {
    if (id.isEmpty || nuevoNombre.isEmpty || nuevoPrecio.isEmpty) {
      throw Exception('Por favor proporciona todos los campos requeridos.');
    }

    var productos = Hive.box('productos');
    productos.put(
      id,
      {
        'id': id,
        'nombre': nuevoNombre,
        'precio': nuevoPrecio,
        'stock': nuevoStock,
      },
    );

    verProductosController.actualizarProductos();
  }
}
