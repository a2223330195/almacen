import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:almacen/Modelo/producto.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:almacen/Vista/almacen_page.dart';
import 'package:almacen/Vista/reportes_page.dart';
import 'package:almacen/Vista/productos_page.dart';
import 'package:almacen/Vista/punto_de_venta_page.dart';
import 'package:almacen/Widgets/custom_button_home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Producto> productos = [
    Producto(
      id: '1',
      nombre: 'Coca-cola',
      precio: 1.5,
    ),
    Producto(
      id: '2',
      nombre: 'Fanta',
      precio: 1.5,
    ),
    Producto(
      id: '3',
      nombre: 'Sprite',
      precio: 1.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Productos'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductosPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Almacén'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlmacenPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Punto de Venta'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PuntoDeVentaPage(productos: productos)),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Reportes'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportesPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Salir'),
              onPressed: () => SystemNavigator.pop(),
            ),
            const SizedBox(height: 20),
            CustomButtonHome(
              name: 'Test Hive',
              color: Colors.blue,
              onPressed: () {
                var productosBox = Hive.box('productos');
                print('Productos: ${productosBox.values}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
