import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/pages/pages.dart';

import 'providers/providers.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [
        ChangeNotifierProvider( create: (_) => UiProvider()),
        ChangeNotifierProvider( create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home_page',
        routes: {
          'home_page':(BuildContext context) => const HomePage(),
          'mapa_page':(BuildContext context) => const MapaPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
           primaryColor: Colors.deepPurple,
           floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple
          )
        ),
      ),
    );

  }
}