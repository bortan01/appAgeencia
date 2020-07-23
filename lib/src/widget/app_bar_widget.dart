import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String titulo;
  final String imagen;
  final String id;

  const AppBarWidget(
      {Key key,
      @required this.titulo,
      @required this.imagen,
      @required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Theme.of(context).accentColor,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Text(
            titulo,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        background: Hero(
          tag: id,
          child: FadeInImage(
            image: NetworkImage(imagen),
            placeholder: AssetImage('assets/img/loading.gif'),
            fadeInDuration: Duration(microseconds: 150000),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
