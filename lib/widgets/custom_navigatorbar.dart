import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';



class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectMenuOpt;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int i) => uiProvider.selectMenuOpt = i,
      items: const [
        BottomNavigationBarItem(
          icon: Icon( Icons.map ),
          label: 'Mapa',          
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.compass_calibration ),
          label: 'Direcciones',          
        ),
      ],

    );
  }
}