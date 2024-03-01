import 'package:flutter/material.dart';
import 'package:almacen/Modelo/producto_modelo.dart';
import 'package:almacen/Controlador/agregar_productos_controller.dart';

class ModificarPage extends StatefulWidget {
  final Producto producto;

  const ModificarPage({Key? key, required this.producto}) : super(key: key);

  @override
  ModificarPageState createState() => ModificarPageState();
}

class ModificarPageState extends State<ModificarPage> {
  final nombreController = TextEditingController();
  final precioController = TextEditingController();
  final agregarProductosController = AgregarProductosController();
  final stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nombreController.text = widget.producto.nombre;
    precioController.text = widget.producto.precio.toString();
    stockController.text = widget.producto.stock.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Modificar Producto',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Introduce el nuevo nombre del producto',
                style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
              ),
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Introduce el nuevo precio del producto',
                style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Introduce el nuevo stock del producto',
                style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
              ),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (nombreController.text.isEmpty ||
                        precioController.text.isEmpty ||
                        stockController.text.isEmpty) {
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
                      nuevoStock: int.parse(stockController.text),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Producto modificado exitosamente!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Modificar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
