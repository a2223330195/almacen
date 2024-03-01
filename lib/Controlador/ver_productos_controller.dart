import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:almacen/Modelo/producto_modelo.dart';

class VerProductosController {
  ValueNotifier<List<Producto>> productos = ValueNotifier<List<Producto>>([]);

  Future<void> actualizarProductos() async {
    var productosBox = await Hive.openBox('productos');
    List<Producto> listaProductos = [];
    for (var key in productosBox.keys) {
      var producto = productosBox.get(key);
      if (producto != null) {
        listaProductos.add(
          Producto(
            id: producto['id'],
            nombre: producto['nombre'],
            precio: double.parse(producto['precio'].toString()),
            stock: producto['stock'] ?? 0,
          ),
        );
      }
    }
    productos.value = listaProductos;
  }

  Future<void> eliminarProducto(String idProducto) async {
    var productosBox = await Hive.openBox('productos');
    await productosBox.delete(idProducto);
    await actualizarProductos();
  }
}
