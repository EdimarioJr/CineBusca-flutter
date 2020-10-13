import 'package:cinebusca_front/providers/jwt_model.dart';
import 'package:cinebusca_front/screens/Watchlist/watchlistpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
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
            child: Row(children: [
              Image(
                  image: AssetImage('assets/cinebusca_logo.png'),
                  width: 100,
                  height: 100),
              Consumer<JwtModel>(
                builder: (context, jwtModel, widget) {
                  if (jwtModel.isLogged()) {
                    Map<String, dynamic> jwtDecoded =
                        JwtDecoder.decode(jwtModel.getToken());
                    String username = jwtDecoded['username'];
                    return Row(children: [
                      Column(
                        children: [
                          Text(
                            "Oi, $username",
                            style: TextStyle(color: Colors.white),
                          ),
                          ElevatedButton(
                            autofocus: true,
                            clipBehavior: Clip.antiAlias,
                            style: new ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(16, 126, 229, 1)),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      vertical: 15.5, horizontal: 15.0)),
                            ),
                            child: Text("Logout"),
                            onPressed: () => {jwtModel.deleteToken()},
                          )
                        ],
                      ),
                      ElevatedButton(
                        autofocus: true,
                        clipBehavior: Clip.antiAlias,
                        style: new ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(16, 126, 229, 1)),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  vertical: 15.5, horizontal: 15.0)),
                        ),
                        child: Text("Watchlist"),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => WatchlistPage()))
                        },
                      )
                    ]);
                  }

                  return Container();
                },
              )
            ]),
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
                  Expanded(
                      flex: 3,
                      child: HeaderButton(
                        buttonText: "Sign in",
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
