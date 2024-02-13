import 'package:hive_flutter/hive_flutter.dart';

class AgregarProductosController {
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

    // productos.delete(key)
  }
}
