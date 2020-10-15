import 'package:cinebusca_front/screens/Movie/castcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MovieCast extends StatelessWidget {
  final List<dynamic> movieCast;

  MovieCast({this.movieCast});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215,
      margin: EdgeInsets.only(bottom: 15.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieCast != null ? movieCast.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return new CastCard(
            urlPhoto: movieCast[index]['profile_path'],
            name: movieCast[index]['name'],
            character: movieCast[index]['character'],
          );
        },
      ),
    );
  }
}
