import 'package:flutter/material.dart';

class CastCard extends StatelessWidget {
  final String name;
  final String character;
  final String urlPhoto;

  CastCard({this.name, this.character, this.urlPhoto});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: urlPhoto != null
                ? Image.network('https://image.tmdb.org/t/p/w342$urlPhoto')
                : Image(image: AssetImage('assets/cinebusca_logo.png')),
          ),
          Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text: TextSpan(
                        text: this.name,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: " as ${this.character}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400))
                        ])),
              )),
        ],
      ),
    );
  }
}
