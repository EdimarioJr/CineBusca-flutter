import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 420,
        margin: EdgeInsets.only(bottom: 30.0),
        padding: EdgeInsets.all(20.0),
        decoration: new BoxDecoration(
          color: Colors.green,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('assets/knives_out_poster.jpg'),
                width: 340,
                height: 340,
              ),
              Text(
                "7.9",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text("Knives Out", style: TextStyle(color: Colors.white))
            ],
          ),
        ));
  }
}
