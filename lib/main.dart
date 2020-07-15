import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:peliculas/src/routes/routes.dart';
import 'package:peliculas/src/page/Colores/Temas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [
        const Locale('es', 'ES'), // American English
        const Locale('en', 'US'), // ESPAÑOL DE ESPAÑA A
        // ...
      ],
      title: 'Agencia Martinez Travels y Tours',
      initialRoute: '/',
      routes: getAplicationRoute(),
      theme: AppTheme.lightTheme,
    );
  }
}
