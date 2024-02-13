import 'package:flutter/material.dart';
import 'package:almacen/Vista/MyHome_page.dart';

void main() {
  runApp(const AlmacenApp());
}

class AlmacenApp extends StatelessWidget {
  const AlmacenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PUNTO DE VENTA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
