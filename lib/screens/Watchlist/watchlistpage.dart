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

  void fetchWatchlist() async {
    JwtModel jwtModel = Provider.of<JwtModel>(context);
    var response = await http.get('http://192.168.18.6:3000/user/watchlist',
        headers: {'Authorization': 'Bearer ${jwtModel.getToken()}'});
    print(response.body);
    var userW = jsonDecode(response.body);
    if (userW['watchlist'] != null) {
      fetchMovies(userW['watchlist']);
    }
  }

  void fetchMovies(List<dynamic> watchlist) async {
    List<MovieCard> userW = [];
    for (var i = 0; i < watchlist.length; i++) {
      var response = await http.get(
          "https://api.themoviedb.org/3/movie/${watchlist[i]}?api_key=0d278f2443cc885c267b521e19ea320e");
      var movie = jsonDecode(response.body);
      print(movie);
      userW.add(new MovieCard(
        movieDirector: "Dallas Jackson",
        movieDescription: movie['overview'],
        movieScore: movie['vote_average'].toString(),
        movieTitle: movie['title'],
        idMovie: movie['id'],
        urlCover: 'https://image.tmdb.org/t/p/w342${movie['poster_path']}',
      ));
    }
    setState(() {
      userMoviesCard = userW;
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
          child: ListView.builder(
        itemCount: this.userMoviesCard != null ? this.userMoviesCard.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return Center(child: this.userMoviesCard[index]);
        },
      )),
    );
  }
}
