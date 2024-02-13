import 'package:flutter/material.dart';
import 'package:almacen/Modelo/producto.dart';

class AltasPage extends StatefulWidget {
  const AltasPage({Key? key, required List<Producto> productos})
      : super(key: key);

  @override
  State<AltasPage> createState() => _AltasPageState();
}

class _AltasPageState extends State<AltasPage> {
  final codigoController = TextEditingController();
  final productoController = TextEditingController();
  final cantidadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Venta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Introduce el código',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: codigoController,
            ),
            const SizedBox(height: 16),
            const Text(
              'Introduce el nombre del producto',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: productoController,
            ),
            const SizedBox(height: 16),
            const Text(
              'Introduce el precio a comprar',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: cantidadController,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (codigoController.text.isEmpty ||
                    productoController.text.isEmpty ||
                    cantidadController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, rellena todos los campos'),
                    ),
                  );
                  return;
                }

                double? cantidad = double.tryParse(cantidadController.text);
                if (cantidad == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, introduce una cantidad válida'),
                    ),
                  );
                  return;
                }

                agregarProducto(
                    id: codigoController.text,
                    nombre: productoController.text,
                    cantidad: cantidad);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Venta guardada'),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  void agregarProducto({
    required String id,
    required String nombre,
    required double cantidad,
  }) {
    // Aquí puedes agregar el código para guardar el producto en tu base de datos o en tu estado de la aplicación.
    print('Producto agregado: $id, $nombre, $cantidad');
  }
}
