import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';

import '../providers/providers.dart';



class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 1,
      onPressed: () async {

        //final barcodeScanRes = 'https://fernando-herrera.com';
        const barcodeScanRes = 'geo:14.449426,-87.631418';

        if (barcodeScanRes == '-1'){
          return;
        }

        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
  
        launchInBrowser(context, nuevoScan);

      },
      child: const Icon( Icons.filter_center_focus_outlined),
    );
  }
}