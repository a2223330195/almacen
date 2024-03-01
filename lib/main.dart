import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:almacen/Vista/my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('productos');
  await Hive.openBox('venta');
  await Hive.openBox('ventas');
  runApp(const AlmacenApp());
}

class AlmacenApp extends StatelessWidget {
  const AlmacenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PUNTO DE VENTA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
