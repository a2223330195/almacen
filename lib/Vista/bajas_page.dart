import 'package:flutter/material.dart';
import 'package:almacen/Controlador/agregar_productos_controller.dart';

class BajasPage extends StatefulWidget {
  const BajasPage({Key? key}) : super(key: key);

  @override
  BajasPageState createState() => BajasPageState();
}

class BajasPageState extends State<BajasPage> {
  final idController = TextEditingController();
  final nombreController = TextEditingController();
  final agregarProductosController = AgregarProductosController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bajas'),
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
              onPressed: () {
                if (idController.text.isEmpty &&
                    nombreController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, rellena uno de los campos'),
                    ),
                  );
                  return;
                }

                agregarProductosController.eliminarProducto(idController.text);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Producto eliminado'),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Eliminar'),
            ),
          ],
        ),
      ),
    );
  }
}
