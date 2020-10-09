import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  final String buttonText;

  HeaderButton({this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      autofocus: true,
      clipBehavior: Clip.antiAlias,
      style: new ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Color.fromRGBO(16, 126, 229, 1)),
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(vertical: 15.5, horizontal: 15.0)),
      ),
      child: Text(this.buttonText),
      onPressed: () => {},
    );
  }
}
