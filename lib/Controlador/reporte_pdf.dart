import 'dart:io';
import 'package:logging/logging.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:almacen/Controlador/reporte_controller.dart';

class ReportePdf {
  final ReporteController reporteController;
  final Logger logger = Logger('ReportePdf');

  ReportePdf({required this.reporteController});

  Future<void> generarReportePdf(TipoReporte tipo) async {
    try {
      final pdf = pw.Document();
      Map<String, double> reporte =
          await reporteController.generarReporte(tipo: tipo);

      List<List<String>> data = [
        ['Fecha', 'Total']
      ];

      reporte.forEach((fecha, total) {
        data.add([fecha, total.toString()]);
      });

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            children: [
              pw.Header(level: 0, child: pw.Text('Reporte de Ventas')),
              pw.TableHelper.fromTextArray(context: context, data: data),
            ],
          ),
        ),
      );

      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String path = '$dir/reporte.pdf';
      final File file = File(path);
      await file.writeAsBytes(await pdf.save());
    } catch (e) {
      logger.severe('Ocurrió un error al generar el reporte: $e');
    }
  }
}
