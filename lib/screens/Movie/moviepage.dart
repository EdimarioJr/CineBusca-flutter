import 'package:flutter/material.dart';
import '../../components/ContainerApp/container_app.dart';
import '../../components/Poster/poster.dart';
import './moviedetail.dart';

class MoviePage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ContainerApp(
      childWidget: Container(
        child: Flexible(
          child: ListView(
            children: [
              Poster(urlCover: this.urlPoster),
              MovieDetail(
                movieDescription: this.movieDescription,
                movieScore: this.movieScore,
                movieTitle: this.movieTitle,
                urlPoster: this.urlPoster,
                idMovie: this.idMovie,
              )
            ],
          ),
        ),
      ),
    );
  }
}
