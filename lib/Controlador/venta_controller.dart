import 'package:hive_flutter/hive_flutter.dart';
import 'package:almacen/Controlador/agregar_productos_controller.dart';

class VentaController {
  final agregarProductosController = AgregarProductosController();

  Future<void> iniciarVenta() async {
    var ventaBox = await Hive.openBox('venta');
    ventaBox.clear();
  }

  Future<void> agregarProductoAVenta(String idProducto, int cantidad) async {
    var productosBox = await Hive.openBox('productos');
    var producto = productosBox.get(idProducto);
    if (producto != null) {
      var ventaBox = await Hive.openBox('venta');

      var productoConCantidad = Map<String, dynamic>.from(producto);
      productoConCantidad['cantidadComprada'] = cantidad;

      ventaBox.add(productoConCantidad);

      producto['stock'] -= cantidad;
      productosBox.put(idProducto, producto);
    }
  }

  Future<double> calcularTotalVenta() async {
    var ventaBox = await Hive.openBox('venta');
    double total = 0.0;
    for (var producto in ventaBox.values) {
      total += double.parse(producto['precio'].toString()) *
          producto['cantidadComprada'];
    }
    return total;
  }

  Future<void> eliminarProductoDeVenta(int index) async {
    var ventaBox = await Hive.openBox('venta');
    var producto = ventaBox.getAt(index);

    var productosBox = await Hive.openBox('productos');
    producto['stock'] += 1;
    productosBox.put(producto['id'], producto);

    ventaBox.deleteAt(index);
  }

  Future<void> finalizarVenta() async {
    var ventaBox = await Hive.openBox('venta');
    var ventasBox = await Hive.openBox('ventas');

    double total = await calcularTotalVenta();

    ventasBox.add({
      'fecha': DateTime.now().toString(),
      'total': total,
      'productos': ventaBox.values.toList(),
    });

    ventaBox.clear();
  }

  Future<List<Map<String, dynamic>>> obtenerVentas() async {
    var ventasBox = await Hive.openBox('ventas');
    return ventasBox.values.map((venta) {
      return Map<String, dynamic>.from(venta);
    }).toList();
  }
}
