import 'package:flutter/cupertino.dart';

class Poster extends StatelessWidget {
  final String urlCover;

  Poster({this.urlCover}) {
    print(this.urlCover);
  }
  @override
  Widget build(BuildContext context) {
    return this.urlCover != null
        ? Image.network(urlCover, width: 210, height: 320)
        : Container();
  }
}
