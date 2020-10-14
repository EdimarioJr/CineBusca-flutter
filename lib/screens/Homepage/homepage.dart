import 'package:flutter/material.dart';
import '../../components/ContainerApp/container_app.dart';
import '../../components/GridMovies/grid_movies.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return ContainerApp(
      childWidget: Container(
        child: GridMovies(),
      ),
    );
  }
}
