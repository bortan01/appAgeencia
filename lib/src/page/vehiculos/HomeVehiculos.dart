import 'package:flutter/material.dart';
import 'package:peliculas/src/models/vehiculo_models.dart';
import 'package:peliculas/src/providers/vehiculo_provider.dart';
import 'package:peliculas/src/widget/card_swiper_widget_vehiculo.dart';
import 'package:peliculas/src/widget/vehiculo_horizontal.dart';

class HomeVehiculos extends StatelessWidget {
  VehiculoProvider autoProvider = new VehiculoProvider();
  @override
  Widget build(BuildContext context) {
    autoProvider.getPopulares();
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Flota de Veliculos"),
        // backgroundColor: Colors.deepPurple,
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
          children: <Widget>[_swiperTarjetas(), _footer(context)],
        ),
      ),
    );
  }

  _swiperTarjetas() {
    ///estos son datos quemados
    List<Vehiculo> autosFicticios = getPeliculaInventada();
    return new CardSwiper(carro: autosFicticios);
  }

  Widget _footer(BuildContext context) {
    List<Vehiculo> autosFicticios = getPeliculaInventada();

    return new Container(
      ///para que tome todo el espacio
      width: double.infinity,

      child: new Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: new Text("Promociones",
                style: Theme.of(context).textTheme.subhead),
            padding: EdgeInsets.only(left: 25.0),
          ),
          new SizedBox(
            height: 5.0,
          ),
          new MovieHorizontal(
              carro: autosFicticios, siguientePagina: () {})
        ],
      ),
    );
  }

  List<Vehiculo> getPeliculaInventada() {
    List<Vehiculo> autosFicticios = new List<Vehiculo>();
    //de momento ocuparemos valores ficticios asi que inventarlos
    autosFicticios.add(
      new Vehiculo(
        posterPath:
            "https://img.autocosmos.com/noticias/fotosprinc/NAZ_d3cd3f472a4f4405aae5e4ac5c243f81.jpg",
        title: "Hyundai",
        originalTitle: "Hyundai",
        backdropPath:
            "https://img.autocosmos.com/noticias/fotosprinc/NAZ_d3cd3f472a4f4405aae5e4ac5c243f81.jpg",
        id: 2312323123,
       overview: descripcion()
      ),
    );

    autosFicticios.add(new Vehiculo(
        posterPath:
            "https://automociontotal.hiperarticulos.com/wp-content/uploads/2015/12/autos-chinos-1.jpg",
        title: "Hyundai Accent 2012",
        originalTitle: "Hyundai Accent 2012",
        backdropPath:
            "https://automociontotal.hiperarticulos.com/wp-content/uploads/2015/12/autos-chinos-1.jpg",
        id: 435345534,
        overview: descripcion()
        ));

    autosFicticios.add(new Vehiculo(
        posterPath:
            "https://www.latercera.com/resizer/BFzSKCqYeOAMrIEtRCKZgW-0UmE=/800x0/smart/arc-anglerfish-arc2-prod-copesa.s3.amazonaws.com/public/ZJPPLCVG7FGU5GHUECVAOV33QY.jpg",
        title: "Azulito",
        originalTitle: "Azulito",
        backdropPath:
            "https://www.latercera.com/resizer/BFzSKCqYeOAMrIEtRCKZgW-0UmE=/800x0/smart/arc-anglerfish-arc2-prod-copesa.s3.amazonaws.com/public/ZJPPLCVG7FGU5GHUECVAOV33QY.jpg",
        id: 3454374523,
         overview: descripcion()
        ));

    autosFicticios.add(new Vehiculo(
        posterPath:
            "https://www.autoshondaenpiura.com/wp-content/uploads/2019/07/wrv-lx.jpg",
        title: "Ocre",
        originalTitle: "Ocre",
        backdropPath:
            "https://www.autoshondaenpiura.com/wp-content/uploads/2019/07/wrv-lx.jpg",
        id: 3454434523,
         overview: descripcion()
        ));

    autosFicticios.add(new Vehiculo(
        posterPath:
            "https://www.cronista.com/export/sites/diarioelcronista/img/2018/04/27/toyotacorollachinanota-01.jpg_956867179.jpg",
        title: "Celeste",
        originalTitle: "Celeste",
        backdropPath:
            "https://www.cronista.com/export/sites/diarioelcronista/img/2018/04/27/toyotacorollachinanota-01.jpg_956867179.jpg",
        id: 34543477523,
         overview: descripcion()
        ));

    return autosFicticios;
  }

 String descripcion(){
   String texto = '¡ ¡ ¡ VÁMONOS A MACHUPICCHU !!!';
 
 return texto;
 }

}
