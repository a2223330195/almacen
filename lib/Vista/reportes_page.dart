import 'package:flutter/material.dart';

class ReportesPage extends StatelessWidget {
  const ReportesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
      ),
      body: const Center(
        child: Text('Página de Reportes'),
      ),
    );
  }
}
