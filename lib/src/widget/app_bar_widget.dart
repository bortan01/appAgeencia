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
      expandedHeight: 250,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Text(
            ///AQUI DEBERIA DE IR UN TITULO
            "",
            style: TextStyle(color: Colors.white, fontSize: 12.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
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
