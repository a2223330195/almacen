import 'package:flutter/material.dart';
import 'package:almacen/Vista/listado_page.dart';
import 'package:almacen/Vista/reportes_page.dart';
import 'package:almacen/Modelo/producto_modelo.dart';
import 'package:almacen/Vista/punto_de_venta_vista.dart';

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
      stock: 4,
    ),
    Producto(
      id: '2',
      nombre: 'Fanta',
      precio: 1.5,
      stock: 5,
    ),
    Producto(
      id: '3',
      nombre: 'Sprite',
      precio: 1.5,
      stock: 9,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          _buildCard('Punto de Venta', Icons.point_of_sale, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PuntoDeVentaVista()),
            );
          }),
          _buildCard('Almacen', Icons.store, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerProductosView(productos: productos)),
            );
          }),
          _buildCard('Reportes', Icons.bar_chart, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReportesPage()),
            );
          }),
          _buildCard('Salir', Icons.exit_to_app, () {
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }

  Card _buildCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2.0,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 50.0,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
