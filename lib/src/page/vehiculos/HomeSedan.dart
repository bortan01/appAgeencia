import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeSedan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Categoria: Sedan'),
      ),
      body: new StaggeredGridView.count(
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        children: <Widget>[
          new _Imagen(
              'https://http2.mlstatic.com/halogenos-neblineros-toyota-yaris-sedan-2009-2011-D_NQ_NP_766311-MEC20549309668_012016-F.jpg',
              1),
          new _Imagen(
              'https://http2.mlstatic.com/halogenos-neblineros-toyota-yaris-sedan-2009-2011-D_NQ_NP_766311-MEC20549309668_012016-F.jpg',
              2),
          new _Imagen(
              'https://http2.mlstatic.com/halogenos-neblineros-toyota-yaris-sedan-2009-2011-D_NQ_NP_766311-MEC20549309668_012016-F.jpg',
              3),
          new _Imagen(
              'https://http2.mlstatic.com/halogenos-neblineros-toyota-yaris-sedan-2009-2011-D_NQ_NP_766311-MEC20549309668_012016-F.jpg',
              4),
          new _Imagen(
              'https://http2.mlstatic.com/halogenos-neblineros-toyota-yaris-sedan-2009-2011-D_NQ_NP_766311-MEC20549309668_012016-F.jpg',
              5),
          new _Imagen(
              'https://http2.mlstatic.com/halogenos-neblineros-toyota-yaris-sedan-2009-2011-D_NQ_NP_766311-MEC20549309668_012016-F.jpg',
              6),
          new _Imagen(
              'https://http2.mlstatic.com/halogenos-neblineros-toyota-yaris-sedan-2009-2011-D_NQ_NP_766311-MEC20549309668_012016-F.jpg',
              7),
          new _Imagen(
              'https://http2.mlstatic.com/halogenos-neblineros-toyota-yaris-sedan-2009-2011-D_NQ_NP_766311-MEC20549309668_012016-F.jpg',
              8),
        ],
        staggeredTiles: const <StaggeredTile>[
          const StaggeredTile.fit(2),
          const StaggeredTile.fit(2),
          const StaggeredTile.fit(1),
          const StaggeredTile.fit(3),
          const StaggeredTile.fit(3),
          const StaggeredTile.fit(1),
          const StaggeredTile.fit(2),
          const StaggeredTile.fit(2),
        ],
      ),
    );
  }
}

class _Imagen extends StatelessWidget {
  const _Imagen(this.source, this.index);

  final String source;
  final int index;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Image.network(source),
          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Column(
              children: <Widget>[
                new Text(
                  'Imagen numbero $index',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  'Mostrando algo',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
