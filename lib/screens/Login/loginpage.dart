import 'package:flutter/material.dart';
import '../../components/ContainerApp/container_app.dart';
import './login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContainerApp(
      childWidget: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
            height: 350,
            margin: EdgeInsets.all(20.0),
            color: Color.fromRGBO(56, 61, 72, 1),
            padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Sign in",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  LoginForm(),
                ],
              ),
            )),
      ),
    );
  }
}
