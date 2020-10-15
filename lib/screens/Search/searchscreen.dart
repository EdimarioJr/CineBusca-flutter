import 'package:cinebusca_front/components/Header/header.dart';
import 'package:cinebusca_front/providers/search_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/GridMovies/grid_movies.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool mudouPesquisa = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(32, 36, 43, 1),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Header(isInSearchPage: true),
            Consumer<SearchModel>(builder: (context, searchModel, widget) {
              print("consumer search ${searchModel.getSearch()}");
              if (searchModel.getSearch() != '') {
                return GridMovies(query: searchModel.getSearch());
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }
}
