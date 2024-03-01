import 'package:flutter/material.dart';
import 'package:almacen/Vista/pdf_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:almacen/Vista/imprimir_ticket.dart';
import 'package:almacen/Controlador/venta_controller.dart';

class PuntoDeVentaVista extends StatefulWidget {
  const PuntoDeVentaVista({Key? key}) : super(key: key);

  @override
  PuntoDeVentaVistaState createState() => PuntoDeVentaVistaState();
}

class PuntoDeVentaVistaState extends State<PuntoDeVentaVista> {
  final ventaController = VentaController();
  final _formKey = GlobalKey<FormState>();
  final _idProductoController = TextEditingController();
  final _cantidadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Center(child: Text('Punto de Venta')),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildForm(),
            const SizedBox(height: 16),
            _buildAgregarProductoButton(),
            _buildListaProductos(),
            _buildTotalVenta(),
            _buildFinalizarVentaButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildTextField(_idProductoController, 'ID del Producto'),
          const SizedBox(height: 16),
          _buildTextField(_cantidadController, 'Cantidad'),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: label,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingresa $label';
          }
          return null;
        },
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildAgregarProductoButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          ventaController.agregarProductoAVenta(
            _idProductoController.text,
            int.parse(_cantidadController.text),
          );
          _idProductoController.clear();
          _cantidadController.clear();
        }
      },
      child: const Text('Agregar Producto'),
    );
  }

  Widget _buildListaProductos() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('venta').listenable(),
      builder: (context, Box box, _) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: box.length,
          itemBuilder: (context, index) {
            var producto = box.getAt(index);
            return ListTile(
              title: Text(producto['nombre']),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ventaController.eliminarProductoDeVenta(index);
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTotalVenta() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('venta').listenable(),
      builder: (context, Box box, _) {
        double total = 0.0;
        for (var producto in box.values) {
          total += double.parse(producto['precio'].toString()) *
              producto['cantidadComprada'];
        }
        return Text(
          'Total De Venta: \$${total.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  Widget _buildFinalizarVentaButton(BuildContext context) {
    return ElevatedButton(
      child: const Text('Finalizar venta'),
      onPressed: () async {
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        final navigator = Navigator.of(context);

        if (mounted) {
          double total = await ventaController.calcularTotalVenta();
          ventaController.finalizarVenta();
          await generarTicket();

          if (mounted) {
            scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(
                    'Venta finalizada. Total: \$${total.toStringAsFixed(2)}'),
              ),
            );

            navigator.push(
              MaterialPageRoute(builder: (context) => const PdfViewPage()),
            );
          }
        }
      },
    );
  }
}
