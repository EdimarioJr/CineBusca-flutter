import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:cinebusca_front/providers/jwt_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetail extends StatefulWidget {
  final String movieDirector;
  final String movieTitle;
  final String movieScore;
  final String movieDescription;
  final String urlPoster;
  final int idMovie;

  MovieDetail(
      {this.movieDescription,
      this.movieTitle,
      this.movieDirector,
      this.movieScore,
      this.urlPoster,
      this.idMovie});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  void postToUserWatchlist() async {
    JwtModel jwtModel = Provider.of<JwtModel>(context, listen: false);
    var response = await http.post('http://192.168.18.6:3000/user/watchlist',
        body: {'idMovie': '${widget.idMovie}'},
        headers: {'Authorization': 'Bearer ${jwtModel.getToken()}'});

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
        height: 400,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(this.widget.urlPoster),
                      fit: BoxFit.cover)),
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
                            movieTitle: this.widget.movieTitle,
                          )),
                          Text(this.widget.movieScore,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          Text(
                            this.widget.movieDescription,
                            style: TextStyle(color: Colors.white),
                          ),
                          Consumer<JwtModel>(
                            builder: (context, jwtModel, widget) {
                              if (jwtModel.isLogged()) {
                                return ElevatedButton(
                                  autofocus: true,
                                  clipBehavior: Clip.antiAlias,
                                  style: new ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromRGBO(16, 126, 229, 1)),
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.symmetric(
                                                vertical: 15.5,
                                                horizontal: 15.0)),
                                  ),
                                  child: Text('Add to watchlist'),
                                  onPressed: () => {postToUserWatchlist()},
                                );
                              } else
                                return Container();
                            },
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
