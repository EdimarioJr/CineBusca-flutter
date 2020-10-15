import 'dart:convert';
import 'package:cinebusca_front/components/ActionButton/actionbutton.dart';
import 'package:cinebusca_front/components/ContainerApp/container_app.dart';
import 'package:cinebusca_front/providers/jwt_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ReviewPage extends StatefulWidget {
  final int idMovie;
  final String urlPoster;
  final String movieTitle;

  ReviewPage({this.idMovie, this.urlPoster, this.movieTitle});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController _reviewController = new TextEditingController();
  bool reviewExists = false;

  void userReviewExists() async {
    JwtModel jwtModel = Provider.of<JwtModel>(context, listen: false);
    String jwtToken = jwtModel.getToken();
    var response = await http.get("http://10.0.0.41:3000/user/reviews",
        headers: {'Authorization': 'Bearer $jwtToken'});

    var reviews = jsonDecode(response.body)['reviews'];
    int indexReview = -1;
    for (int i = 0; i < reviews.length; i++) {
      if (reviews[i]['idMovie'] == widget.idMovie) indexReview = i;
    }
    print(indexReview);
    if (indexReview != -1)
      this._reviewController.text = reviews[indexReview]['review'];
  }

  void putWatchlist() async {
    JwtModel jwtModel = Provider.of<JwtModel>(context, listen: false);
    var jwtToken = jwtModel.getToken();
    // O pacote http do dart só consegue mandar parametros em string ou bool. Como a api do NEST
    // só aceita parametros inteiros para o idMovie, codifiquei o body em json e mandei. O Header
    // Content-Type é fundamental para essa abordagem funcionar.
    var bodyRequest = jsonEncode(
        {'idMovie': widget.idMovie, 'review': this._reviewController.text});
    var response = await http.post(
      "http://10.0.0.41:3000/user/reviews",
      headers: {
        'Authorization': 'Bearer $jwtToken',
        "Content-Type": "application/json"
      },
      body: bodyRequest,
    );
    print(response.body);
  }

  void initState() {
    super.initState();
    userReviewExists();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerApp(
      childWidget: Container(
        margin: EdgeInsets.all(20.0),
        alignment: Alignment.centerLeft,
        child: Column(children: [
          Row(
            children: [
              widget.urlPoster != null
                  ? Image.network(widget.urlPoster, height: 130)
                  : Image(image: AssetImage(widget.urlPoster)),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text(widget.movieTitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
          Container(
            height: 300,
            margin: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              maxLines: 1000,
              autofocus: true,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              controller: _reviewController,
              decoration: InputDecoration(
                filled: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                fillColor: Color.fromRGBO(255, 255, 255, 1),
                contentPadding: const EdgeInsets.all(10.0),
                hintText: "Escreva aqui sua review",
              ),
            ),
          ),
          ActionButton(
            textButton: "Salvar Alterações",
            onPressedFunc: () {
              print(_reviewController.text);
              this.putWatchlist();
            },
          )
        ]),
      ),
    );
  }
}
