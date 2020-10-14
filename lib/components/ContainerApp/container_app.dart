import 'package:flutter/material.dart';
import '../Header/header.dart';

class ContainerApp extends StatelessWidget {
  final Widget childWidget;

  ContainerApp({this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(20, 20, 21, 1),
            child: SingleChildScrollView(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [Header(), this.childWidget],
              ),
            ))));
  }
}
