import 'package:flutter/material.dart';
import 'header_button.dart';

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
                      width: 200,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            filled: true,
                            hintText: "Search by film title",
                            border: const OutlineInputBorder(),
                            fillColor: Color.fromRGBO(255, 255, 255, 1),
                            contentPadding: const EdgeInsets.only(left: 10.0)),
                      ))),
              HeaderButton(buttonText: "Go!")
            ],
          ),
        ));
  }
}
