import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../screens/Movie/MoviePage.dart';

class MovieCard extends StatelessWidget {
  final String urlCover;
  final String movieTitle;
  final String movieScore;
  final String movieDescription;
  final String movieDirector;

  MovieCard(
      {this.urlCover,
      this.movieScore,
      this.movieTitle,
      this.movieDescription,
      this.movieDirector});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => MoviePage(
                        urlPoster: this.urlCover,
                        movieScore: this.movieScore,
                        movieTitle: this.movieTitle,
                        movieDescription: this.movieDescription,
                        movieDirector: this.movieDirector,
                      )));
        },
        child: Container(
            width: 250,
            height: 400,
            margin: EdgeInsets.only(bottom: 10.0),
            padding: EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              color: Colors.black,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    urlCover,
                    width: 210,
                    height: 320,
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
                  SizedBox(
                    width: 210,
                    child: Text(this.movieTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            )));
  }
}
