import 'package:flutter/material.dart';
import 'package:almacen/Modelo/producto_modelo.dart';
import 'package:almacen/Controlador/agregar_productos_controller.dart';

class ModificarPage extends StatefulWidget {
  final Producto producto;

  const ModificarPage({Key? key, required this.producto}) : super(key: key);

  @override
  _ModificarPageState createState() => _ModificarPageState();
}

class _ModificarPageState extends State<ModificarPage> {
  final nombreController = TextEditingController();
  final precioController = TextEditingController();
  final agregarProductosController = AgregarProductosController();

  @override
  void initState() {
    super.initState();
    nombreController.text = widget.producto.nombre;
    precioController.text = widget.producto.precio.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modificar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Introduce el nuevo nombre del producto',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: nombreController,
            ),
            const SizedBox(height: 16),
            const Text(
              'Introduce el nuevo precio del producto',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: precioController,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (nombreController.text.isEmpty ||
                    precioController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, rellena todos los campos'),
                    ),
                  );
                  return;
                }

                agregarProductosController.modificarProducto(
                  id: widget.producto.id,
                  nuevoNombre: nombreController.text,
                  nuevoPrecio: precioController.text,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Producto modificado'),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Modificar'),
            ),
          ],
        ),
      ),
    );
  }
}
