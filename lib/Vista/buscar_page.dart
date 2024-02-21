import 'package:flutter/material.dart';
import 'package:almacen/Controlador/buscar_productos_controller.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({Key? key}) : super(key: key);

  @override
  _BuscarPageState createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  final idController = TextEditingController();
  final nombreController = TextEditingController();
  final buscarProductosController = BuscarProductosController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Introduce el código del producto',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: idController,
            ),
            const SizedBox(height: 16),
            const Text(
              'O introduce el nombre del producto',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: nombreController,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                if (idController.text.isEmpty &&
                    nombreController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, rellena uno de los campos'),
                    ),
                  );
                  return;
                }

                var productoPorId = await buscarProductosController
                    .buscarProductoPorId(idController.text);
                var productoPorNombre = await buscarProductosController
                    .buscarProductoPorNombre(nombreController.text);

                if (productoPorId != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Producto encontrado: ${productoPorId.nombre}'),
                    ),
                  );
                } else if (productoPorNombre != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Producto encontrado: ${productoPorNombre.nombre}'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Producto no encontrado'),
                    ),
                  );
                }
              },
              child: const Text('Buscar'),
            ),
          ],
        ),
      ),
    );
  }
}
