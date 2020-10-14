import 'dart:convert';
import 'dart:ui';
import 'package:cinebusca_front/components/ActionButton/actionbutton.dart';
import 'package:http/http.dart' as http;
import 'package:cinebusca_front/providers/jwt_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetail extends StatefulWidget {
  final String movieDirector;
  final String movieTitle;
  final String movieScore;
  final String movieDescription;
  final String urlPoster;
  final int idMovie;

  MovieDetail(
      {this.movieDescription,
      this.movieTitle,
      this.movieDirector,
      this.movieScore,
      this.urlPoster,
      this.idMovie});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  bool isMovieInWatchlist = false;

  void postToUserWatchlist() async {
    // Listen = false por que esse método só altera o estado global,
    // não é afetado por ele, então não precisa ficar "acompanhando" o estado global
    JwtModel jwtModel = Provider.of<JwtModel>(context, listen: false);
    var response = await http.post('http://10.0.0.41:3000/user/watchlist',
        body: {'idMovie': '${widget.idMovie.toInt()}'},
        headers: {'Authorization': 'Bearer ${jwtModel.getToken()}'});

    if (jsonDecode(response.body)['op'] == true) {
      setState(() {
        isMovieInWatchlist = true;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Filme adicionado a sua watchlist!"),
        backgroundColor: Colors.blueAccent,
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Algum erro ocorreu :/"),
        backgroundColor: Colors.redAccent,
      ));
    }
    print(response.body);
  }

  void isMovieIn() async {
    JwtModel jwtModel = Provider.of<JwtModel>(context, listen: false);
    var response = await http.get('http://10.0.0.41:3000/user/watchlist',
        headers: {'Authorization': 'Bearer ${jwtModel.getToken()}'});
    var resposta = jsonDecode(response.body);
    if (resposta['op'] == true) {
      if (resposta['watchlist'].indexOf(widget.idMovie.toString()) != -1) {
        setState(() {
          isMovieInWatchlist = true;
        });
      }
    } else {
      print(resposta);
    }
  }

  void deleteFromWatchlist() async {
    JwtModel jwtModel = Provider.of<JwtModel>(context, listen: false);
    var response = await http.delete(
        'http://10.0.0.41:3000/user/watchlist/${widget.idMovie}',
        headers: {'Authorization': 'Bearer ${jwtModel.getToken()}'});

    if (jsonDecode(response.body)['op'] == true) {
      setState(() {
        isMovieInWatchlist = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Filme retirado da sua watchlist!"),
        backgroundColor: Colors.blueAccent,
      ));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Algum erro ocorreu :/"),
        backgroundColor: Colors.redAccent,
      ));
    }
    print(response.body);
  }

  @override
  // ignore: must_call_super
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    isMovieIn();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
        height: 400,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(this.widget.urlPoster),
                      fit: BoxFit.cover)),
            ),
            ClipRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 35.0),
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: MovieHeader(
                            movieDirector: 'Dallas Jackson',
                            movieTitle: this.widget.movieTitle,
                          )),
                          Text(this.widget.movieScore,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          Text(
                            this.widget.movieDescription,
                            style: TextStyle(color: Colors.white),
                          ),
                          Consumer<JwtModel>(
                            builder: (context, jwtModel, widget) {
                              if (jwtModel.isLogged()) {
                                return Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: ActionButton(
                                    textButton: isMovieInWatchlist
                                        ? "Remove from watchlist"
                                        : "Add to Watchlist",
                                    verticalPadding: 20,
                                    horizontalPadding: 30,
                                    isBlue: isMovieInWatchlist ? false : true,
                                    onPressedFunc: isMovieInWatchlist
                                        ? deleteFromWatchlist
                                        : postToUserWatchlist,
                                  ),
                                );
                              } else
                                return Container();
                            },
                          )
                        ],
                      ))),
            )
          ],
        ));
  }
}

class MovieHeader extends StatelessWidget {
  final String movieTitle;
  final String movieDirector;

  MovieHeader({this.movieTitle, this.movieDirector});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: RichText(
          text: TextSpan(
            text: this.movieTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                  text: " by ", style: TextStyle(fontWeight: FontWeight.w300)),
              TextSpan(
                  text: this.movieDirector,
                  style: TextStyle(fontWeight: FontWeight.w300))
            ],
          ),
        ));
  }
}
