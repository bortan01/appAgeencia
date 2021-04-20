import 'package:flutter/material.dart';

enum TypeChip { rojo, verde, azul, amarillo }

class ChipWidget extends StatelessWidget {
  final TypeChip type;
  final String text;
  const ChipWidget({Key key, @required this.type, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (this.type) {
      case TypeChip.rojo:
        return panel(text, Colors.red);
        break;
      case TypeChip.verde:
        return panel(text, Colors.green);
        break;
      case TypeChip.azul:
        return panel(text, Colors.blue);
        break;
      case TypeChip.amarillo:
        return panel(text, Colors.yellowAccent);
        break;
      default:
        return panel(text, Colors.yellowAccent);
        break;
    }
  }

  Widget panel(String text, Color textColor) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(50),
      ),
      child: Text(
        text,
        maxLines: 3,
        style: TextStyle(color: textColor, fontSize: 15),
      ),
    );
  }
}
