import 'package:flutter/material.dart';
import 'package:almacen/Modelo/producto_modelo.dart';
import 'package:almacen/Controlador/ver_productos_controller.dart';

class VerProductosView extends StatelessWidget {
  final verProductosController = VerProductosController();

  VerProductosView({Key? key, required List<Producto> productos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ver productos')),
      body: FutureBuilder(
        future: verProductosController.actualizarProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ValueListenableBuilder<List<Producto>>(
              valueListenable: verProductosController.productos,
              builder: (context, productos, child) {
                return ListView(
                  // Cambio de Column a ListView
                  children: productos
                      .map(
                        (Producto producto) => ListTile(
                          leading: CircleAvatar(
                            child: Text(producto.id),
                          ),
                          title: Text(producto.nombre),
                          subtitle: Text(producto.precio.toString()),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await verProductosController
                                  .eliminarProducto(producto.id as int);
                            },
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
