import 'package:flutter/material.dart';
import '../ActionButton/actionbutton.dart';

class FormHeader extends StatefulWidget {
  @override
  _FormHeaderState createState() => _FormHeaderState();
}

class _FormHeaderState extends State<FormHeader> {
  final _formKey = GlobalKey<FormState>();
  String titleMovie = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SizedBox(
          width: 250,
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 7,
                  child: Container(
                      child: TextFormField(
                    decoration: const InputDecoration(
                        filled: true,
                        hintText: "Search by film title",
                        border: const OutlineInputBorder(),
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
                        contentPadding: const EdgeInsets.only(left: 10.0)),
                  ))),
              ActionButton(
                textButton: "Go!",
                verticalPadding: 15.5,
                horizontalPadding: 15.0,
                onPressedFunc: () => {},
              )
            ],
          ),
        ));
  }
}
