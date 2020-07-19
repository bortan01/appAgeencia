import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeSedan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String argumento = ModalRoute.of(context).settings.arguments;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Categoria: ' + argumento),
      ),
      body: new StaggeredGridView.count(
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        children: <Widget>[
          new _Imagen(
              'https://www.kbb.com/wp-content/uploads/2019/10/01-2018-Honda-Accord-Exterior-BB-KBB.jpg',
              1),
          new _Imagen(
              'https://http2.mlstatic.com/halogenos-neblineros-toyota-yaris-sedan-2009-2011-D_NQ_NP_766311-MEC20549309668_012016-F.jpg',
              2),
          new _Imagen(
              'https://the-drive.imgix.net/https%3A%2F%2Fapi.thedrive.com%2Fwp-content%2Fuploads%2F2017%2F11%2Fhonda-civic-si-featured.jpg%3Fquality%3D85?w=1440&auto=compress%2Cformat&ixlib=js-1.4.1&s=f19c120f9017e364e9431253656e7e17',
              3),
          new _Imagen(
              'https://cdn.drivek.it/configurator-covermobile/cars/es/500/AUDI/RS3/31305_SEDAN-4-PUERTAS/audi-rs3-sedan-cover-mobile.jpg',
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
          const StaggeredTile.count(4, 3.5),
          const StaggeredTile.count(2, 1.5),
          const StaggeredTile.count(2, 1.5),
          const StaggeredTile.count(4, 3),
          const StaggeredTile.count(2, 1.5),
          const StaggeredTile.count(2, 1.5),
          const StaggeredTile.count(4, 2.5),
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
            padding: const EdgeInsets.all(0.25),
            child: new Column(
              children: <Widget>[
                new Text(
                  'Imagen $index',
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
