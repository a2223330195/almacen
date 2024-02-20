import 'package:hive_flutter/hive_flutter.dart';

class BuscarProductosController {
  Future<Map<String, dynamic>?> buscarProductoPorId(String id) async {
    var productos = Hive.box('productos');
    var producto = productos.get(id);
    if (producto == null) {
      throw Exception('Producto no encontrado');
    }
    return producto;
  }

  Future<Map<String, dynamic>?> buscarProductoPorNombre(String nombre) async {
    var productos = Hive.box('productos');
    for (var key in productos.keys) {
      var producto = productos.get(key);
      if (producto != null && producto['nombre'] == nombre) {
        return producto;
      }
    }
    throw Exception('Producto no encontrado');
  }
}
