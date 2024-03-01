import 'dart:io';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

Future<void> generarTicket() async {
  final Logger logger = Logger('generarTicket');
  try {
    final pdf = pw.Document();

    var ventaBox = await Hive.openBox('venta');
    List<List<String>> data = [
      ['ID', 'Nombre', 'Precio', 'Cantidad'] // Cambié 'Stock' a 'Cantidad'
    ];
    double total = 0.0;

    for (var producto in ventaBox.values) {
      data.add([
        producto['id'],
        producto['nombre'],
        producto['precio'].toString(),
        producto['cantidadComprada']
            .toString() // Cambié el stock del producto por la cantidad comprada
      ]);
      total += double.parse(producto['precio'].toString()) *
          producto['cantidadComprada'];
    }

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Header(level: 0, child: pw.Text('Ticket de Venta')),
            pw.TableHelper.fromTextArray(context: context, data: data), // Corrección del problema 1
            pw.Padding(padding: const pw.EdgeInsets.all(10)),
            pw.Paragraph(text: 'Total: $total'),
          ],
        ),
      ),
    );

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/ticket.pdf';
    logger.info('Ruta al archivo PDF: $path'); // Corrección del problema 2
    final File file = File(path);
    await file.writeAsBytes(await pdf.save());
  } catch (e) {
    logger.severe('Ocurrió un error al generar el ticket: $e'); // Corrección del problema 3
  }
}