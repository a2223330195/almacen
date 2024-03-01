import 'dart:io';
import 'dart:async';
import 'package:pdf/pdf.dart';
import 'package:share/share.dart';
import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerPage extends StatefulWidget {
  final String path;

  const PdfViewerPage({Key? key, required this.path}) : super(key: key);

  @override
  PdfViewerPageState createState() => PdfViewerPageState();
}

class PdfViewerPageState extends State<PdfViewerPage> {
  bool isReady = false;
  int pages = 0;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  final Logger _logger = Logger('PdfViewerPage');

  @override
  void initState() {
    super.initState();
    if (File(widget.path).existsSync()) {
      setState(() {
        isReady = true;
      });
    }
  }

  Future<void> printPdf() async {
    final File file = File(widget.path);

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => file.readAsBytes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              await Share.shareFiles([widget.path], text: 'Aquí está tu PDF.');
            },
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: printPdf,
          ),
        ],
      ),
      body: isReady
          ? PDFView(
              filePath: widget.path,
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
                _logger.severe('Error al renderizar el PDF: $error');
              },
              onPageError: (page, error) {
                _logger.severe('Error en la página $page: $error');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onPageChanged: (int? page, int? total) {
                _logger.info('Cambio de página: $page/$total');
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
