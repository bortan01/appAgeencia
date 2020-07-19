import 'package:flutter/material.dart';
import 'package:peliculas/src/models/paquete_models.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/providers/paquete_provider.dart';
import 'package:peliculas/src/widget/horizontalPaquete.dart';

class ListaPaquetes extends StatelessWidget {
  final PaqueteProvider peliculaProvider = new PaqueteProvider();
  @override
  Widget build(BuildContext context) {
    final String argumento = ModalRoute.of(context).settings.arguments;
    peliculaProvider.getPopulares();
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Paquetes " + argumento),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                //showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      body: new Container(
        //color: Colors.greenAccent,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[_swiperTarjetas(context), _footer(context)],
        ),
      ),
    );
  }

  _swiperTarjetas(BuildContext context) {
    ///estos son datos quemados
    List<Paquete> paquetes = getPeliculaInventada();
    final tamanioPantalla = MediaQuery.of(context).size;
    print("el tamano es " + tamanioPantalla.height.toString());

    return Container(
      //color: Colors.blue,
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: tamanioPantalla.width * 0.8,
        itemHeight: tamanioPantalla.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          paquetes[index].uniqueId = '${paquetes[index].id}-tarjeta';
          return Container(
            child: Hero(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                    child: GestureDetector(
                      onTap: () {
                        final tou = paquetes[index];

                        Navigator.pushNamed(context, 'DetallePaquetes',
                            arguments: tou);
                      },
                      child: FadeInImage(
                        image: NetworkImage(paquetes[index].getPosterImg()),
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              tag: paquetes[index].uniqueId,
            ),
          );
        },
        itemCount: paquetes.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}

Widget _footer(BuildContext context) {
  List<Paquete> peliculasFicticias = getPeliculaInventada();
  final tamanioPantalla = MediaQuery.of(context).size;
  double espacioDisponible = (tamanioPantalla.height) * 0.28;
  return new Container(
    ///para que tome todo el espacio
    width: double.infinity,

    child: new Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: new Text("Promociones",
              style: Theme.of(context).textTheme.subtitle1),
          padding: EdgeInsets.only(left: 25.0),
        ),
        new SizedBox(
          height: 5.0,
        ),
        new HorizontalPaquete(
            paquetes: peliculasFicticias,
            especioDisponible: espacioDisponible,
            siguientePagina: () {})
      ],
    ),
  );
}

List<Paquete> getPeliculaInventada() {
  String direccion =
      'https://ik.imagekit.io/tvlk/xpe-asset/AyJ40ZAo1DOyPyKLZ9c3RGQHTP2oT4ZXW+QmPVVkFQiXFSv42UaHGzSmaSzQ8DO5QIbWPZuF+VkYVRk6gh-Vg4ECbfuQRQ4pHjWJ5Rmbtkk=/9593070784419/Big-Bus-Paris-Hop-On-Hop-Off-Tour-3d13f9f8-f228-4788-8c78-91a144a75431.jpeg?_src=imagekit&tr=q-60,c-at_max,w-720,h-512';
  List<Paquete> peliculasFicticias = new List<Paquete>();
  //de momento ocuparemos valores ficticios asi que inventarlos
  peliculasFicticias.add(
    new Paquete(
        posterPath: direccion,
        title: "Macupichu",
        originalTitle: "Machupichu",
        backdropPath: direccion,
        id: 2312323123,
        incluye: [
          "Hotel",
          "Desayuno",
          "Transporte",
          "Refrigerio",
          "Gia Turistico"
        ]),
  );

  peliculasFicticias.add(new Paquete(
    posterPath: direccion,
    title: "Nicaragua",
    originalTitle: "Nicaragua",
    backdropPath: direccion,
    id: 435345534,
  ));

  peliculasFicticias.add(new Paquete(
    posterPath: direccion,
    title: "Volcan de Conchagua",
    originalTitle: "Volcan de Conchagua",
    backdropPath: direccion,
    id: 3454374523,
  ));

  peliculasFicticias.add(new Paquete(
    posterPath: direccion,
    title: "Panama",
    originalTitle: "Panama",
    backdropPath: direccion,
    id: 3454434523,
  ));

  peliculasFicticias.add(new Paquete(
    posterPath: direccion,
    title: "Costa Rica",
    originalTitle: "Costa Rica",
    backdropPath: direccion,
    id: 34543477523,
  ));

  return peliculasFicticias;
}
