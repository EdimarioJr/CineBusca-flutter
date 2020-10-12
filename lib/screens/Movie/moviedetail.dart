import 'dart:ui';

import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  final String movieDirector;
  final String movieTitle;
  final String movieScore;
  final String movieDescription;
  final String urlPoster;

  MovieDetail(
      {this.movieDescription,
      this.movieTitle,
      this.movieDirector,
      this.movieScore,
      this.urlPoster}) {
    print(this.urlPoster);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
        height: 350,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(this.urlPoster), fit: BoxFit.cover)),
            ),
            ClipRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 35.0),
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: MovieHeader(
                            movieDirector: 'Dallas Jackson',
                            movieTitle: this.movieTitle,
                          )),
                          Text(this.movieScore,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          Text(
                            this.movieDescription,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ))),
            )
          ],
        ));
  }
}

class MovieHeader extends StatelessWidget {
  final String movieTitle;
  final String movieDirector;

  MovieHeader({this.movieTitle, this.movieDirector});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: RichText(
          text: TextSpan(
            text: this.movieTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                  text: " by ", style: TextStyle(fontWeight: FontWeight.w300)),
              TextSpan(
                  text: this.movieDirector,
                  style: TextStyle(fontWeight: FontWeight.w300))
            ],
          ),
        ));
  }
}
