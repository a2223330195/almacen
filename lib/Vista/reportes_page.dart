import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:almacen/Vista/pdf_view_reportes.dart';
import 'package:almacen/Controlador/reporte_pdf.dart';
import 'package:almacen/Controlador/venta_controller.dart';
import 'package:almacen/Controlador/reporte_controller.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({Key? key}) : super(key: key);

  @override
  ReportesPageState createState() => ReportesPageState();
}

class ReportesPageState extends State<ReportesPage> {
  late ReporteController reporteController;
  ReportePdf? reportePdf;
  Map<String, double>? reporteActual;
  TipoReporte tipoReporte = TipoReporte.diario;

  @override
  void initState() {
    super.initState();
    var ventaController = VentaController();
    reporteController = ReporteController(ventaController: ventaController);
    cargarReporte();
  }

  Future<void> cargarReporte() async {
    reporteActual = await reporteController.generarReporte(tipo: tipoReporte);
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> generarReportePdf() async {
    reportePdf = ReportePdf(reporteController: reporteController);
    await reportePdf!.generarReportePdf(tipoReporte);

    final dir = (await getApplicationDocumentsDirectory()).path;

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewerPage(path: '$dir/reporte.pdf'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Text('Reportes'),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.timer),
              label: const Text('Selecciona el intervalo de tiempo'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              onPressed: () async {
                final seleccionado = await showDialog<TipoReporte>(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text('Selecciona el intervalo de tiempo'),
                      children: TipoReporte.values.map((TipoReporte value) {
                        return SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, value);
                          },
                          child: Text(value.toString().split('.').last),
                        );
                      }).toList(),
                    );
                  },
                );
                if (seleccionado != null && mounted) {
                  setState(() {
                    tipoReporte = seleccionado;
                    cargarReporte();
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Generar Reporte PDF'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              onPressed: () async {
                await generarReportePdf();
              },
            ),
          ],
        ),
      ),
    );
  }
}
