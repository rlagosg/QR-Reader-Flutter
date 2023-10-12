import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';

import '../providers/providers.dart';

class ScanTiles extends StatelessWidget {

  final String tipo;

  const ScanTiles({super.key, required this.tipo});


  @override
  Widget build(BuildContext context) {
    

    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: ( _, i ) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          //child: const Text('Hola mundo'),          
        ),
        onDismissed: (direction) {
          Provider.of<ScanListProvider>(context, listen: false).borrarPorId(scans[i].id!);
        },
        child: ListTile(
          leading: Icon( 
            tipo == 'http'
            ? Icons.map_outlined
            : Icons.home_outlined,             
            color: Theme.of(context).primaryColor, 
          ),
          title: Text( scans[i].valor ),
          subtitle: Text(  scans[i].id.toString() ),
          trailing: const Icon( Icons.keyboard_arrow_right, color: Colors.grey,),
          onTap: () => launchInBrowser(context, scans[i]),
        ),
      )
    );
  }
}