import 'dart:convert';
import 'package:cinebusca_front/components/ContainerApp/container_app.dart';
import 'package:cinebusca_front/components/MovieCard/movie_card.dart';
import 'package:cinebusca_front/providers/jwt_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  List<MovieCard> userMoviesCard;
  int nItems = 0;

  void fetchWatchlist() async {
    JwtModel jwtModel = Provider.of<JwtModel>(context);
    // Captura o token do usuário Atual ( É garantido que tenha um usuário logado, por que o botão
    // para acessar essa página só aparece quando tem um token no estado global) e manda o token no
    // headers da requisição HTTP
    var response = await http.get('http://10.0.0.41:3000/user/watchlist',
        headers: {'Authorization': 'Bearer ${jwtModel.getToken()}'});
    // captura e decodifica o json
    var userW = jsonDecode(response.body);
    // Se a watchlist existir conter algum item..
    if (userW['watchlist'] != null) {
      fetchMovies(userW['watchlist']);
    }
  }

  // Função que usa os ids da watchlist do usuário para puxar informações sobre os filmes
  void fetchMovies(List<dynamic> watchlist) async {
    List<MovieCard> userW = [];
    // a cada loop: Requisição a API -> Decodifica o Json resposta -> monta o card -> coloca no array userW

    for (var i = 0; i < watchlist.length; i++) {
      var response = await http.get(
          "https://api.themoviedb.org/3/movie/${watchlist[i]}?api_key=0d278f2443cc885c267b521e19ea320e");
      var movie = jsonDecode(response.body);
      userW.add(new MovieCard(
        movieDirector: "Dallas Jackson",
        movieDescription: movie['overview'],
        movieScore: movie['vote_average'].toString(),
        movieTitle: movie['title'],
        idMovie: movie['id'],
        urlCover: 'https://image.tmdb.org/t/p/w342${movie['poster_path']}',
      ));
    }
    // Seta a watchlist e o numero de items na watchlist
    setState(() {
      userMoviesCard = userW;
      nItems = userW.length;
    });
  }

  @override
  // ignore: must_call_super
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    fetchWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerApp(
      childWidget: Flexible(
          child: GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
              children: List.generate(nItems, (index) {
                return userMoviesCard[index];
              }))),
    );
  }
}
