import 'package:flutter/cupertino.dart';

class SearchModel extends ChangeNotifier {
  String searchText = '';

  void setSearch(String value) {
    this.searchText = value;
    notifyListeners();
  }

  bool isSearching() {
    if (this.searchText == '') return false;
    return true;
  }

  String getSearch() {
    return this.searchText;
  }
}
