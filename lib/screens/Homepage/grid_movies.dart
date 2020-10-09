import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class GridMovies extends StatefulWidget {
  final List<Widget> movies;

  GridMovies({this.movies});

  @override
  _GridMoviesState createState() => _GridMoviesState();
}

class _GridMoviesState extends State<GridMovies> {
  Object fetchedMovies;

  void fetchMovies() async {
    http.Response response = await http.get(Uri.encodeFull(
        "https://api.themoviedb.org/3/discover/movie?api_key=0d278f2443cc885c267b521e19ea320e&sort_by=popularity.desc"));

    var movies = jsonDecode(response.body);
    print(movies);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView(
      children: [...widget.movies],
    ));
  }
}
