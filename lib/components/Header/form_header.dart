import 'package:cinebusca_front/providers/search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ActionButton/actionbutton.dart';
import '../../screens/Search/searchscreen.dart';

class FormHeader extends StatefulWidget {
  final bool isInSearchPage;

  FormHeader({this.isInSearchPage = false});

  @override
  _FormHeaderState createState() => _FormHeaderState();
}

class _FormHeaderState extends State<FormHeader> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _searchTextController = new TextEditingController();
  String titleMovie = '';

  void setSearchText() {
    SearchModel searchModel = Provider.of<SearchModel>(context, listen: false);
    searchModel.setSearch(_searchTextController.text.toString());
    print(searchModel.getSearch());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SizedBox(
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 7,
                  child: TextFormField(
                    controller: _searchTextController,
                    validator: (value) {
                      if (value.isEmpty)
                        return "Por favor preencha o campo!";
                      else
                        return null;
                    },
                    decoration: const InputDecoration(
                        filled: true,
                        hintText: "Search by film title",
                        border: const OutlineInputBorder(),
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
                        contentPadding: const EdgeInsets.only(left: 10.0)),
                  )),
              ActionButton(
                textButton: "Go!",
                verticalPadding: 15.5,
                horizontalPadding: 15.0,
                onPressedFunc: () {
                  if (_formKey.currentState.validate()) {
                    setSearchText();
                    if (!widget.isInSearchPage) {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SearchPage()));
                    }
                  }
                },
              )
            ],
          ),
        ));
  }
}
