import 'dart:convert';
import 'package:cinebusca_front/screens/Movie/moviecast.dart';
import 'package:flutter/material.dart';
import '../../components/ContainerApp/container_app.dart';
import '../../components/Poster/poster.dart';
import './moviedetail.dart';
import 'package:http/http.dart' as http;

class MoviePage extends StatefulWidget {
  final String movieTitle;
  final String movieScore;
  final String movieDescription;
  final String urlPoster;
  final int idMovie;

  MoviePage(
      {this.movieDescription,
      this.movieScore,
      this.movieTitle,
      this.urlPoster,
      this.idMovie});

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  String movieDirector;
  List<dynamic> movieCast;

  void fetchMovieDirector() async {
    var response = await http.get(
        'https://api.themoviedb.org/3/movie/${widget.idMovie}/credits?api_key=0d278f2443cc885c267b521e19ea320e');
    var resposta = jsonDecode(response.body);
    String diretor = '';
    resposta['crew'].forEach((elemento) {
      if (elemento['job'] == 'Director') diretor = elemento['name'];
    });
    setState(() {
      this.movieDirector = diretor;
      this.movieCast = resposta['cast'];
    });
  }

  void initState() {
    super.initState();
    fetchMovieDirector();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerApp(
      childWidget: Container(
        child: Flexible(
          child: ListView(
            children: [
              Poster(urlCover: this.widget.urlPoster),
              MovieDetail(
                movieDescription: this.widget.movieDescription,
                movieScore: this.widget.movieScore,
                movieTitle: this.widget.movieTitle,
                urlPoster: this.widget.urlPoster,
                idMovie: this.widget.idMovie,
                movieDirector: this.movieDirector,
              ),
              MovieCast(
                movieCast: this.movieCast,
              )
            ],
          ),
        ),
      ),
    );
  }
}
