import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../components/MovieCard/movie_card.dart';

class GridMovies extends StatefulWidget {
  @override
  _GridMoviesState createState() => _GridMoviesState();
}

class _GridMoviesState extends State<GridMovies> {
  List<dynamic> movies;
  int paginaAtual;
  ScrollController _scrollController = new ScrollController();
  bool isFetchingMovies = true;

  Future fetchMovies(int pag) async {
    var s = pag.toString();
    setState(() {
      isFetchingMovies = true;
    });
    final response = await http.get(
        "https://api.themoviedb.org/3/discover/movie?api_key=0d278f2443cc885c267b521e19ea320e&sort_by=popularity.desc&page=$s");
    this.setState(() {
      var resposta = jsonDecode(response.body);
      paginaAtual = pag;
      movies != null
          ? movies = [...movies, ...resposta['results']]
          : movies = resposta['results'];
      print(movies.length);
      isFetchingMovies = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent)
          this.fetchMovies(paginaAtual + 1);
      });
    this.fetchMovies(1);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: movies != null ? movies.length : 0,
            itemBuilder: (BuildContext context, int index) {
              String caminhoPoster = movies[index]['poster_path'];
              if (movies.length == index + 1) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Opacity(
                      opacity: 1,
                      child: new CircularProgressIndicator(),
                    ),
                  ),
                );
              } else
                return Center(
                    child: new MovieCard(
                  urlCover: 'https://image.tmdb.org/t/p/w342/$caminhoPoster',
                  movieTitle: movies[index]['title'],
                  movieScore: movies[index]['vote_average'].toString(),
                  movieDescription: movies[index]['overview'],
                ));
            }));
  }
}
