import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../MovieCard/movie_card.dart';

class GridMovies extends StatefulWidget {
  final String query;

  GridMovies({this.query = ''});

  @override
  _GridMoviesState createState() => _GridMoviesState();
}

class _GridMoviesState extends State<GridMovies> {
  List<dynamic> movies;
  int paginaAtual;
  int nItems = 0;
  ScrollController _scrollController = new ScrollController();
  bool isFetchingMovies = true;

  Future fetchMovies(int pag) async {
    var s = pag.toString();
    setState(() {
      isFetchingMovies = true;
    });
    final response = await http.get(widget.query == ''
        ? "https://api.themoviedb.org/3/discover/movie?api_key=0d278f2443cc885c267b521e19ea320e&sort_by=popularity.desc&page=$s"
        : "https://api.themoviedb.org/3/search/movie?api_key=0d278f2443cc885c267b521e19ea320e&query=${widget.query}&include_adult=false&page=$s");
    this.setState(() {
      var resposta = jsonDecode(response.body);
      paginaAtual = pag;
      movies != null
          ? movies = [...movies, ...resposta['results']]
          : movies = resposta['results'];
      print(movies.length);
      nItems = movies.length;
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
        child: GridView.count(
            controller: _scrollController,
            padding: EdgeInsets.all(8.0),
            // Numero de colunas
            crossAxisCount: 2,
            // Define o tamanho da Row da grid, ou o height dos grid items
            childAspectRatio: 0.55,
            // os Grid gap
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
            // Nesse sentido é parecido com listview.builder, apesar do gridview tambem ter o builder
            // para lidar com requisições a api e grids "infinitos"
            children: List.generate(nItems, (index) {
              String caminhoPoster = movies[index]['poster_path'];
              if (movies.length == index) {
                return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: new CircularProgressIndicator(),
                    ));
              } else {
                return new MovieCard(
                  urlCover: caminhoPoster,
                  movieTitle: movies[index]['title'],
                  movieScore: movies[index]['vote_average'].toString(),
                  movieDescription: movies[index]['overview'],
                  idMovie: movies[index]['id'],
                );
              }
            })));
  }
}
