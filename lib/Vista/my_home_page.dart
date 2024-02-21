import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:almacen/Vista/almacen_page.dart';
import 'package:almacen/Vista/reportes_page.dart';
import 'package:almacen/Vista/productos_page.dart';
import 'package:almacen/Modelo/producto_modelo.dart';
import 'package:almacen/Vista/punto_de_venta_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
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
              child: const Text('Punto de Venta'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlmacenPage()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Almacen'),
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
          ],
        ),
      ),
    );
  }
}
