import 'package:cinebusca_front/providers/jwt_model.dart';
import 'package:cinebusca_front/screens/Watchlist/watchlistpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import '../../screens/Login/loginpage.dart';
import '../../screens/Watchlist/watchlistpage.dart';
import 'form_header.dart';
import '../ActionButton/actionbutton.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  // GlobalKey serve para identificar unicamente um form, assim podemos usar os controllers de texto
  // nos campos e facilitar a vida na manipulação e captura de valores em um formulário.
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
              Expanded(
                flex: 5,
                // Usamos o Image para renderizar imagens no flutter. Esse Widget Image pode ter
                // vários tipos no seu argumento "image". O caso abaixo é AssetImage, o que significa
                // que a imagem vai ser buscada nos assets do projeto. Também existe o NetworkImage,
                // significando que a imagem vai ser buscada em alguma URL
                child: Image(
                    image: AssetImage('assets/cinebusca_logo.png'),
                    width: 100,
                    height: 100),
              ),
              // O Consumer acompanha as mudanças que ocorrem no estado do Provider Jwt
              // Ele fornece a instância do Model através do jwtModel, assim podemos modificar
              // o estado global da aplicação ( nesse caso o estado global se resume ao jwt)
              Consumer<JwtModel>(
                builder: (context, jwtModel, widget) {
                  if (jwtModel.isLogged()) {
                    // decodifica o token
                    Map<String, dynamic> jwtDecoded =
                        JwtDecoder.decode(jwtModel.getToken());
                    // pega o username do payload e usa no Text
                    String username = jwtDecoded['username'];
                    return Expanded(
                      flex: 5,
                      child: Column(children: [
                        Text(
                          "Bem vindo, $username",
                          style: TextStyle(color: Colors.white),
                        ),
                        ActionButton(
                          textButton: "Watchlist",
                          onPressedFunc: () => {
                            // Com o Navigator push mudamos de uma tela para outra no Flutter
                            // Usei o CupertinoPageRoute por que eu acho a animação do Cupertino mais
                            // bonita :D
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => WatchlistPage()))
                          },
                        )
                      ]),
                    );
                  }
                  // Um Consumer não pode retornar null, tem que retornar pelo menos 1 widget
                  return Container();
                },
              )
            ]),
          ),
          // SizedBox define uma altura / largura para Column,Row, Flex..
          SizedBox(
              width: MediaQuery.of(context).size.width,
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
                      child: Consumer<JwtModel>(
                          builder: (context, jwtModel, widget) {
                        bool userIsLogged = jwtModel.isLogged();
                        // O texto do botão e o que ele faz vai depender do estado da aplicação
                        // Se o estado muda, esse botão automaticamente vai mudar, por que ele está
                        // encapsulado pelo Consumer e será notificado sobre todas as mudanças.
                        return ActionButton(
                          verticalPadding: 15.5,
                          horizontalPadding: 15.0,
                          textButton: userIsLogged ? "Logout" : "Sign in",
                          onPressedFunc: () => {
                            userIsLogged
                                ? jwtModel.deleteToken()
                                : Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => LoginPage()))
                          },
                        );
                      })),
                ],
              )),
        ],
      ),
    );
  }
}
