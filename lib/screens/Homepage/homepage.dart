import 'package:flutter/material.dart';
import '../../components/ContainerApp/container_app.dart';
import '../../components/MovieCard/movie_card.dart';
import './grid_movies.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return ContainerApp(
      childWidget: Container(
        child: GridMovies(movies: [MovieCard(), MovieCard()]),
      ),
    );
  }
}
