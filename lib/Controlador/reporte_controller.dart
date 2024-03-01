import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:almacen/Controlador/venta_controller.dart';

enum TipoReporte { diario, semanal, mensual }

class ReporteController {
  final VentaController ventaController;
  final Logger _logger = Logger('ReporteController');

  ReporteController({required this.ventaController});

  DateTime calcularFinMes(DateTime fecha) {
    if (fecha.month < 12) {
      return DateTime(fecha.year, fecha.month + 1, 1)
          .subtract(const Duration(days: 1));
    } else {
      return DateTime(fecha.year + 1, 1, 1);
    }
  }

  Future<Map<String, double>> generarReporte(
      {required TipoReporte tipo}) async {
    Map<String, double> reporte = {};
    DateTime ahora = DateTime.now();
    DateTime inicio;
    DateTime fin;

    switch (tipo) {
      case TipoReporte.diario:
        inicio = DateTime(ahora.year, ahora.month, ahora.day)
            .subtract(const Duration(days: 1));
        fin = DateTime(ahora.year, ahora.month, ahora.day);
        break;
      case TipoReporte.semanal:
        inicio = ahora.subtract(Duration(days: ahora.weekday - 1));
        fin = inicio.add(const Duration(days: 7));
        break;
      case TipoReporte.mensual:
        inicio = DateTime(ahora.year, ahora.month, 1);
        fin = calcularFinMes(ahora);
        if (ahora.isBefore(fin)) {
          fin = ahora;
        }
        break;
      default:
        throw 'Tipo de reporte no válido';
    }

    try {
      var ventas = await ventaController.obtenerVentas();
      for (var venta in ventas) {
        DateTime fechaVenta =
            DateFormat('yyyy-MM-dd').parse(venta['fecha'].toString());
        if (fechaVenta.isAfter(inicio) &&
            (fechaVenta.isBefore(fin) || fechaVenta.isAtSameMomentAs(fin))) {
          if (reporte.containsKey(venta['fecha'])) {
            reporte[venta['fecha']] = (reporte[venta['fecha']] ?? 0) +
                double.parse(venta['total'].toString());
          } else {
            reporte[venta['fecha']] = (reporte[venta['fecha']] ?? 0) +
                double.parse(venta['total'].toString());
          }
        }
      }
    } catch (error) {
      _logger.severe('Error al obtener las ventas: $error');
    }

    return reporte;
  }
}
