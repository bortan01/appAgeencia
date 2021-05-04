import 'package:flutter/material.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';

Widget descripcion(String descripcion) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 15),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          descripcion,
          overflow: TextOverflow.ellipsis,
          maxLines: 50,
          textAlign: TextAlign.justify,
          style: AppTheme.h6Style.copyWith(fontSize: 15, color: Colors.blueGrey),
        ),
      ),
    ],
  );
}
