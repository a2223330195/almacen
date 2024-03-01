import 'dart:io';
import 'dart:async';
import 'package:pdf/pdf.dart';
import 'package:share/share.dart';
import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewPage extends StatefulWidget {
  const PdfViewPage({super.key});

  @override
  PdfViewPageState createState() => PdfViewPageState();
}

class PdfViewPageState extends State<PdfViewPage> {
  String path = '';
  bool isReady = false;
  int pages = 0;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  final Logger logger = Logger('PdfViewPage');

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    path = '$dir/ticket.pdf';
    if (File(path).existsSync()) {
      setState(() {
        isReady = true;
      });
    }
  }

  Future<void> printPdf() async {
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/ticket.pdf';
    final File file = File(path);

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => file.readAsBytes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket PDF'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              final String dir =
                  (await getApplicationDocumentsDirectory()).path;
              final String path = '$dir/ticket.pdf';

              await Share.shareFiles([path],
                  text: 'Aquí está tu ticket de venta.');
            },
          ),
        ],
      ),
      body: isReady
          ? PDFView(
              filePath: path,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              onRender: (pages) {
                setState(() {
                  this.pages = pages!;
                });
              },
              onError: (error) {
                logger.severe(error.toString());
              },
              onPageError: (page, error) {
                logger.severe('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onPageChanged: (int? page, int? total) {
                logger.info('page change: $page/$total');
              },
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: printPdf,
        child: const Icon(Icons.print),
      ),
    );
  }
}
