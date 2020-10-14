import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../screens/Movie/MoviePage.dart';

class MovieCard extends StatelessWidget {
  final String urlCover;
  final String movieTitle;
  final String movieScore;
  final String movieDescription;
  final int idMovie;

  MovieCard(
      {this.urlCover,
      this.movieScore,
      this.movieTitle,
      this.movieDescription,
      this.idMovie});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
          color: Color.fromRGBO(56, 61, 72, 1),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => MoviePage(
                        urlPoster: this.urlCover,
                        movieScore: this.movieScore,
                        movieTitle: this.movieTitle,
                        movieDescription: this.movieDescription,
                        idMovie: this.idMovie)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                urlCover,
                height: 230,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  this.movieScore,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Text(this.movieTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ],
          ),
        ));
  }
}
