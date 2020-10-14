import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../screens/Login/loginpage.dart';

// Botão que vai ser reusado por toda a aplicação
class ActionButton extends StatelessWidget {
  final String textButton;
  final Function onPressedFunc;
  final double verticalPadding;
  final double horizontalPadding;
  final bool isBlue;

  ActionButton(
      {this.onPressedFunc,
      this.textButton,
      // Valores padrão
      this.verticalPadding = 10.0,
      this.horizontalPadding = 15.0,
      this.isBlue = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      autofocus: true,
      clipBehavior: Clip.antiAlias,
      style: new ButtonStyle(
        backgroundColor: isBlue
            ? MaterialStateProperty.all<Color>(Color.fromRGBO(16, 126, 229, 1))
            : MaterialStateProperty.all<Color>(Color.fromRGBO(244, 66, 54, 1)),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
            vertical: this.verticalPadding,
            horizontal: this.horizontalPadding)),
      ),
      child: Text(this.textButton),
      onPressed: this.onPressedFunc != null
          ? this.onPressedFunc
          : () => {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => LoginPage()))
              },
    );
  }
}
