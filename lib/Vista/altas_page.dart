import 'package:flutter/material.dart';
import 'package:almacen/Modelo/producto_modelo.dart';
import 'package:almacen/Controlador/agregar_productos_controller.dart';

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
  final stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alta de Productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: codigoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Introduce el código',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Introduce el nombre del producto',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: cantidadController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Introduce el precio a comprar',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Introduce el stock',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (codigoController.text.isEmpty ||
                      productoController.text.isEmpty ||
                      cantidadController.text.isEmpty ||
                      stockController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, rellena todos los campos'),
                      ),
                    );
                    return;
                  }

                  double? cantidad = double.tryParse(cantidadController.text);
                  int? stock = int.tryParse(stockController.text);
                  if (cantidad == null || stock == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Por favor, introduce una cantidad y stock válidos'),
                      ),
                    );
                    return;
                  }

                  agregarProducto(
                    id: codigoController.text,
                    nombre: productoController.text,
                    cantidad: cantidad,
                    stock: stock,
                  );

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
      ),
    );
  }

  void agregarProducto({
    required String id,
    required String nombre,
    required double cantidad,
    required int stock,
  }) {
    AgregarProductosController().agregarProducto(
      id: id,
      nombre: nombre,
      precio: cantidad.toString(),
      stock: stock,
    );
  }
}
