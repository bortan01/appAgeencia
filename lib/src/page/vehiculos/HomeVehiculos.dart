import 'package:flutter/material.dart';
import 'package:peliculas/src/models/paquete_models.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:peliculas/src/widget/horizontalPaquete.dart';

class HomeVehiculos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Flota de Vehiculos"),
        // backgroundColor: Colors.deepPurple,
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

                        Navigator.pushNamed(context, 'DetalleVehiculos',
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
  List<Paquete> peliculasFicticias = new List<Paquete>();
  //de momento ocuparemos valores ficticios asi que inventarlos
  peliculasFicticias.add(
    new Paquete(
        posterPath:
            "https://www.brenson.com.ar/img/vehiculos/banner-vehiculos-sm-2.png",
        title: "Macupichu",
        originalTitle: "Machupichu",
        backdropPath: "https://www.brenson.com.ar/img/vehiculos/banner-vehiculos-sm-2.png",
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
    posterPath:
        "https://www.brenson.com.ar/img/vehiculos/ecosport/banner-ecosport-sm.jpg",
    title: "Nicaragua",
    originalTitle: "Nicaragua",
    backdropPath:
        "https://www.brenson.com.ar/img/vehiculos/ecosport/banner-ecosport-sm.jpg",
    id: 435345534,
  ));

  peliculasFicticias.add(new Paquete(
    posterPath:
        "https://www.brenson.com.ar/img/vehiculos/banner-vehiculos-sm-1.png",
    title: "Volcan de Conchagua",
    originalTitle: "Volcan de Conchagua",
    backdropPath:
        "https://www.brenson.com.ar/img/vehiculos/banner-vehiculos-sm-1.png",
    id: 3454374523,
  ));

  peliculasFicticias.add(new Paquete(
    posterPath:
        "https://imagenes-cdn.autofacil.es/multimedia/fotos/2020/04/10/184138/tesla-model3-2018-1024-02-68_mg.jpg",
    title: "Panama",
    originalTitle: "Panama",
    backdropPath:
        "https://imagenes-cdn.autofacil.es/multimedia/fotos/2020/04/10/184138/tesla-model3-2018-1024-02-68_mg.jpg",
    id: 3454434523,
  ));

  peliculasFicticias.add(new Paquete(
    posterPath:
        "https://www.excelenciasdelmotor.com/sites/default/files/inline-images/tesla-model-x.jpg",
    title: "Costa Rica",
    originalTitle: "Costa Rica",
    backdropPath:
        "https://www.excelenciasdelmotor.com/sites/default/files/inline-images/tesla-model-x.jpg",
    id: 34543477523,
  ));

  return peliculasFicticias;
}
