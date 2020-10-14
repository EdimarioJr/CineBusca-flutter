import 'package:cinebusca_front/providers/search_model.dart';

import './providers/jwt_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/Homepage/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JwtModel>.value(value: JwtModel()),
        ChangeNotifierProvider<SearchModel>.value(value: SearchModel())
      ],
      child: MaterialApp(
        title: 'Cinebusca App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.

          // Como ele recebe uma palheta de cores(swatch) nao podemos colocar
          // aqui uma cor especifica individual ( como black ou white ou teal[100])
          primarySwatch: Colors.blueGrey,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Cinebusca App'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    // O metodo build vai ser executado toda vez que o setState for chamado
    // O flutter tem mecanismos de otimizacao que deixam esse build rapido
    return Homepage();
  }
}
