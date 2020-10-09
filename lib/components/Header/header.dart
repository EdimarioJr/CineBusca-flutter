import 'package:flutter/material.dart';
import 'form_header.dart';
import 'header_button.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final _formKey = GlobalKey<FormState>();
  String titleMovie = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      margin: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Center(
                child: Image(
                    image: AssetImage('assets/cinebusca_logo.png'),
                    width: 100,
                    height: 100)),
          ),
          // SizedBox define uma altura / largura para Column,Row, Flex..
          SizedBox(
              width: 450,
              // Definindo o tamanho da Row, podemos usar o Expanded dentro dela para definir o tamanho dos seus elementos sem ser hard-coded.
              // Nesse exemplo o input Text + Button ocupam 70% do width (flex = 7) e o outro button ocupa os outros 30% ( flex = 3). Isso foi possivel
              // por que definimos o tamanho do seu elemento Pai (Row) atraves do SizedBox.
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: FormHeader()),
                  ),
                  Expanded(flex: 3, child: HeaderButton(buttonText: "Sign in"))
                ],
              )),
        ],
      ),
    );
  }
}
