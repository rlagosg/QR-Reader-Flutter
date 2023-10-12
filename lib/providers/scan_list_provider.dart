import 'package:flutter/material.dart';
import 'package:qr_reader/providers/providers.dart';

class ScanListProvider extends ChangeNotifier {

  //lista global
  List<ScanModel> scans = [];
  //el tipo de direcciones de la app
  String tipoSeleccionado = 'http';

  //metodos globales
  Future<ScanModel> nuevoScan( String valor ) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //asignar el id de la base de datos
    nuevoScan.id = id;

    if( tipoSeleccionado == nuevoScan.tipo ){
      scans.add(nuevoScan);
      //notificar a la aplicacion
      notifyListeners();
    }

    return nuevoScan;
  }

  cargarScans() async{
    final scans = await DBProvider.db.getTodosLosScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipo( String tipo) async {
    final scans = await DBProvider.db.getScansPorTipo( tipo );
    this.scans = [...scans];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  borrarPorId( int id ) async {
    await DBProvider.db.deleteScan(id);
    cargarScansPorTipo(tipoSeleccionado);
  }

}