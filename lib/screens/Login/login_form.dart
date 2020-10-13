import '../../providers/jwt_model.dart';
import 'package:cinebusca_front/screens/Homepage/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final userPasswordController = TextEditingController();
  bool createUser = false;

  setToken(String token) {
    JwtModel jwtModel = Provider.of<JwtModel>(context, listen: false);
    jwtModel.setToken(token);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: TextFormField(
                  controller: userNameController,
                  validator: (value) {
                    if (value.isEmpty)
                      return "Por favor preencha o campo!";
                    else
                      return null;
                  },
                  decoration:
                      InputDecoration(hintText: "Name", labelText: "Name"),
                ),
              ),
              TextFormField(
                controller: userPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty)
                    return "Por favor preencha o campo!";
                  else
                    return null;
                },
                decoration: InputDecoration(
                    hintText: "Password", labelText: "Password"),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(16, 126, 229, 1)),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20.0)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print(userNameController.text);
                        print(userPasswordController.text);
                        var responseLogin = await http.post(
                            'http://10.0.0.41:3000/user/${createUser ? '' : 'login'}',
                            body: {
                              'name': userNameController.text,
                              'password': userPasswordController.text
                            });

                        var respostaLogin = jsonDecode(responseLogin.body);
                        print(respostaLogin);
                        if (createUser == true) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(respostaLogin['message']),
                            backgroundColor: respostaLogin['op']
                                ? Colors.blueAccent
                                : Colors.redAccent,
                          ));
                        } else {
                          if (respostaLogin['message'] == 'Unauthorized') {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Usuário ou senha incorretos!"),
                              backgroundColor: Colors.redAccent,
                            ));
                          } else {
                            this.setToken(respostaLogin['access_token']);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Entrando na conta..."),
                              backgroundColor: Colors.blueAccent,
                            ));
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Homepage()));
                            });
                          }
                        }
                      }
                    },
                    child: Text(createUser ? "Sign up" : "Sign in",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: RichText(
                  text: TextSpan(
                      text: createUser
                          ? "Already have an account?"
                          : "Don't have an account?",
                      children: [
                        TextSpan(
                            text: createUser ? " Sign in" : " Sign up",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {
                                    setState(() {
                                      createUser = !createUser;
                                    })
                                  })
                      ]),
                ),
              )
            ],
          ),
        ));
  }
}
