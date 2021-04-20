import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/preferencias/preferencias_usuario.dart';
import 'package:peliculas/src/providers/push_notification_provider.dart';
import 'package:peliculas/src/routes/routes.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    final pushProvider = new PushNotificationProvider();
    pushProvider.iniciarNotificaciones();
    pushProvider.mensajesStreams.listen((String argumento) {
      // print("argumento desde main $argumento");
      navigatorKey.currentState.pushNamed(argumento);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pref = PreferenciasUsuario();
    print(pref.paginaInicio);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => new TurServices(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: [
          const Locale('es', 'ES'), // American English
          const Locale('en', 'US'), // ESPAÑOL DE ESPAÑA A
          // ...
        ],
        title: 'Agencia Martinez Travels y Tours',
        // initialRoute: 'login',
        initialRoute: pref.paginaInicio,
        routes: getAplicationRoute(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
