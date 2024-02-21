import 'package:flutter/material.dart';
import 'package:almacen/Vista/modificar_page.dart';
import 'package:almacen/Modelo/producto_modelo.dart';
import 'package:almacen/Controlador/ver_productos_controller.dart';
import 'package:almacen/Controlador/buscar_productos_controller.dart';
import 'package:almacen/Vista/altas_page.dart'; // Asegúrate de importar la página de altas

class VerProductosView extends StatefulWidget {
  final verProductosController = VerProductosController();

  VerProductosView({Key? key, required List<Producto> productos})
      : super(key: key);

  @override
  _VerProductosViewState createState() => _VerProductosViewState();
}

class _VerProductosViewState extends State<VerProductosView> {
  final TextEditingController _searchController = TextEditingController();
  final BuscarProductosController _buscarProductosController =
      BuscarProductosController();
  final ValueNotifier<Producto?> _productoBuscado = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almacen'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AltasPage(
                    productos: widget.verProductosController.productos.value,
                  ),
                ),
              ).then((_) {
                widget.verProductosController.actualizarProductos();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: widget.verProductosController.actualizarProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar producto por ID o nombre',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          var text = _searchController.text;
                          if (text.isNotEmpty) {
                            var producto = await _buscarProductosController
                                .buscarProductoPorId(text);
                            if (producto == null) {
                              producto = await _buscarProductosController
                                  .buscarProductoPorNombre(text);
                            }
                            _productoBuscado.value = producto;
                          }
                        },
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder<Producto?>(
                  valueListenable: _productoBuscado,
                  builder: (context, producto, child) {
                    if (producto != null) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(producto.id),
                        ),
                        title: Text(producto.nombre),
                        subtitle: Text(producto.precio.toString()),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                Expanded(
                  child: ValueListenableBuilder<List<Producto>>(
                    valueListenable: widget.verProductosController.productos,
                    builder: (context, productos, child) {
                      return ListView(
                        children: productos
                            .map(
                              (Producto producto) => ListTile(
                                leading: CircleAvatar(
                                  child: Text(producto.id),
                                ),
                                title: Text(producto.nombre),
                                subtitle: Text(producto.precio.toString()),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ModificarPage(
                                              producto: producto,
                                            ),
                                          ),
                                        ).then((_) {
                                          widget.verProductosController
                                              .actualizarProductos();
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        await widget.verProductosController
                                            .eliminarProducto(producto.id);
                                        widget.verProductosController
                                            .actualizarProductos();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
