import 'package:hive_flutter/hive_flutter.dart';
import 'package:almacen/Modelo/producto_modelo.dart';

class BuscarProductosController {
  Future<Producto?> buscarProductoPorId(String id) async {
    var productos = Hive.box('productos');
    var producto = productos.get(id);
    if (producto != null) {
      return Producto(
        id: producto['id'],
        nombre: producto['nombre'],
        precio: double.parse(producto['precio'].toString()),
      );
    } else {
      return null;
    }
  }

  Future<Producto?> buscarProductoPorNombre(String nombre) async {
    var productos = Hive.box('productos');
    for (var key in productos.keys) {
      var producto = productos.get(key);
      if (producto != null && producto['nombre'] == nombre) {
        return Producto(
          id: producto['id'],
          nombre: producto['nombre'],
          precio: double.parse(producto['precio'].toString()),
        );
      }
    }
    return null;
  }
}
