import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'http');
  }
}