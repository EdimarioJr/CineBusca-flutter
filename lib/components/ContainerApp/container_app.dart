import 'package:flutter/material.dart';
import '../Header/header.dart';

class ContainerApp extends StatelessWidget {
  final Widget childWidget;

  ContainerApp({this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: 430,
            color: Color.fromRGBO(32, 36, 42, 1),
            child: Column(
              children: [Header(), this.childWidget],
            )));
  }
}
