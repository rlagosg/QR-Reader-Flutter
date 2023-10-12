import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/pages/pages.dart';
import 'package:qr_reader/widgets/widgets.dart';

import '../providers/providers.dart';



class HomePage extends StatelessWidget {
   
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          //boton borrar
          IconButton(onPressed: () {  
            //accion boton borrar
            Provider.of<ScanListProvider>(context, listen: false).borrarTodos();

          }, icon: const Icon( Icons.delete))
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigatorBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 
    );
  }
}

class _HomePageBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {



    //obtener el select menu op del provider
    final uiProvider = Provider.of<UiProvider>(context);
    
    //cambiar para mostrar pagina
    final currentIndex = uiProvider.selectMenuOpt;
    final nuevoScanTemp = ScanModel(valor: 'http://google.com');

    //usar el scanprovider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    //leer la base de datos
    //DBProvider.db.nuevoScan(nuevoScanTemp);
    //DBProvider.db.getTodosLosScans().then( print );
    //DBProvider.db.deleteAllScan().then(print);


    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();
      case 1:
      scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }

    return Container();
  }
}