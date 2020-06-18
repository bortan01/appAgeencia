import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_models.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widget/card_swiper_widget.dart';
import 'package:peliculas/src/widget/movie_horizontal.dart';

class HomePaquetes extends StatelessWidget {
  PeliculaProvider peliculaProvider = new PeliculaProvider();
  @override
  Widget build(BuildContext context) {
    peliculaProvider.getPopulares();
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Paquetes"),
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
    List<Pelicula> peliculasFicticias = getPeliculaInventada();
    return new CardSwiper(peliculas: peliculasFicticias);
  }

  Widget _footer(BuildContext context) {
    List<Pelicula> peliculasFicticias = getPeliculaInventada();

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
              peliculas: peliculasFicticias, siguientePagina: () {})
        ],
      ),
    );
  }

  List<Pelicula> getPeliculaInventada() {
    List<Pelicula> peliculasFicticias = new List<Pelicula>();
    //de momento ocuparemos valores ficticios asi que inventarlos
    peliculasFicticias.add(
      new Pelicula(
        posterPath:
            "https://scontent-mia3-1.xx.fbcdn.net/v/t1.0-9/86437795_990747354659293_6900039684588568576_o.jpg?_nc_cat=111&_nc_sid=8bfeb9&_nc_ohc=McZ61rvEjAIAX_yEGWH&_nc_ht=scontent-mia3-1.xx&oh=331ab5d816a2a2a79e034ffcf40b27ad&oe=5F1212A1",
        title: "Macupichu",
        originalTitle: "Machupichu",
        backdropPath:
            "https://scontent-mia3-1.xx.fbcdn.net/v/t1.0-9/86437795_990747354659293_6900039684588568576_o.jpg?_nc_cat=111&_nc_sid=8bfeb9&_nc_ohc=McZ61rvEjAIAX_yEGWH&_nc_ht=scontent-mia3-1.xx&oh=331ab5d816a2a2a79e034ffcf40b27ad&oe=5F1212A1",
        id: 2312323123,
       overview: descripcion()
      ),
    );

    peliculasFicticias.add(new Pelicula(
        posterPath:
            "https://scontent-mia3-2.xx.fbcdn.net/v/t1.0-9/84811539_986682118399150_14819376632954880_o.jpg?_nc_cat=110&_nc_sid=8bfeb9&_nc_ohc=j9--zEYgvzAAX8jEVHl&_nc_ht=scontent-mia3-2.xx&oh=e1997a49e898f0f4ccc973545d77ee63&oe=5F0FB3BE",
        title: "Nicaragua",
        originalTitle: "Nicaragua",
        backdropPath:
            "https://scontent-mia3-2.xx.fbcdn.net/v/t1.0-9/84811539_986682118399150_14819376632954880_o.jpg?_nc_cat=110&_nc_sid=8bfeb9&_nc_ohc=j9--zEYgvzAAX8jEVHl&_nc_ht=scontent-mia3-2.xx&oh=e1997a49e898f0f4ccc973545d77ee63&oe=5F0FB3BE",
        id: 435345534,
        overview: descripcion()
        ));

    peliculasFicticias.add(new Pelicula(
        posterPath:
            "https://scontent-mia3-1.xx.fbcdn.net/v/t1.0-9/83469740_980152025718826_5435872388350738432_o.jpg?_nc_cat=104&_nc_sid=730e14&_nc_ohc=Q5xrv_l69pYAX8qiA3K&_nc_ht=scontent-mia3-1.xx&oh=da08867f63178a698d1c60ae8a281dfb&oe=5F0FDC9D",
        title: "Volcan de Conchagua",
        originalTitle: "Volcan de Conchagua",
        backdropPath:
            "https://scontent-mia3-1.xx.fbcdn.net/v/t1.0-9/83469740_980152025718826_5435872388350738432_o.jpg?_nc_cat=104&_nc_sid=730e14&_nc_ohc=Q5xrv_l69pYAX8qiA3K&_nc_ht=scontent-mia3-1.xx&oh=da08867f63178a698d1c60ae8a281dfb&oe=5F0FDC9D",
        id: 3454374523,
         overview: descripcion()
        ));

    peliculasFicticias.add(new Pelicula(
        posterPath:
            "https://scontent-mia3-2.xx.fbcdn.net/v/t1.0-9/83353671_979272542473441_6245999208600436736_o.jpg?_nc_cat=110&_nc_sid=730e14&_nc_ohc=VTpH_iWIZogAX9iLJ_f&_nc_ht=scontent-mia3-2.xx&oh=27e5e3323016fa931ff51e5df2a6d364&oe=5F108691",
        title: "Panama",
        originalTitle: "Panama",
        backdropPath:
            "https://scontent-mia3-2.xx.fbcdn.net/v/t1.0-9/83353671_979272542473441_6245999208600436736_o.jpg?_nc_cat=110&_nc_sid=730e14&_nc_ohc=VTpH_iWIZogAX9iLJ_f&_nc_ht=scontent-mia3-2.xx&oh=27e5e3323016fa931ff51e5df2a6d364&oe=5F108691",
        id: 3454434523,
         overview: descripcion()
        ));

    peliculasFicticias.add(new Pelicula(
        posterPath:
            "https://scontent-mia3-1.xx.fbcdn.net/v/t1.0-9/83024125_970138793386816_6359243176774991872_o.jpg?_nc_cat=101&_nc_sid=730e14&_nc_ohc=F-Z1W_fsV34AX9njbLb&_nc_ht=scontent-mia3-1.xx&oh=ba4047d0c69ac63b6c3be7711445baf9&oe=5F0F9424",
        title: "Costa Rica",
        originalTitle: "Costa Rica",
        backdropPath:
            "https://scontent-mia3-1.xx.fbcdn.net/v/t1.0-9/83024125_970138793386816_6359243176774991872_o.jpg?_nc_cat=101&_nc_sid=730e14&_nc_ohc=F-Z1W_fsV34AX9njbLb&_nc_ht=scontent-mia3-1.xx&oh=ba4047d0c69ac63b6c3be7711445baf9&oe=5F0F9424",
        id: 34543477523,
         overview: descripcion()
        ));

    return peliculasFicticias;
  }

 String descripcion(){
   String texto = '¡ ¡ ¡ VÁMONOS A MACHUPICCHU !!!'+
'FECHA: Paquete disponible año 2020;'+
'VISITANDO:'+
'✔ City Tour en Cusco'+
'✔ Tour del Valle Sagrado de los Incas'+
'✔ Ollantaytambo'+
'✔ Aguas Calientes'+
'✔ Machu Picchu.'+
'✔Otros.'+
'INCLUYE:'+
'• Traslados : Aeropuerto - Hotel – Aeropuerto en Cusco'+
'• Ticket de Tren : Ollantaytambo - Aguas Calientes – Ollantaytambo (Servicio Expedition).'+
'• Bus Turístico : Aguas Calientes - Machu Picchu - Aguas Calientes.'+
'• Viaje en Van : Estación de Ollantaytambo – Cusco.'+
'• Guía Profesional de Turismo para todos los lugares de vista.'+
'• Ticket de ingresos - BOLETO TURÍSTICO GENERAL (BTG).'+
'• Tickets de Ingreso a Machu Picchu.'+
'• Almuerzo en restaurant turístico en Aguas Calientes (No incluye bebidas)'+
'• Guía Profesional en Machupicchu.'+
'• Asistencia constante durante el tour.'+
'• 03 noches de hotel 3* en Cusco. (Htl Royal inca u otro de similar categoría)'+
'• 01 noche de hotel en 3* en Aguas Calientes. (Htl Flower´s u otro de similar categoría)'+
'• Acomodación doble o matrimonial en todos los hoteles'+
'NO INCLUYE'+
'• Alimentos no mencionados en el itinerario.'+
'• Gastos extras ni propinas.'+
'• Ingresos a la montaña Huaynapicchu o montaña Machupicchu (sujetos a disponibilidad).'+
'• Vuelo a Cusco.'+
'• Seguro de viajes.'+
'PRECIO'+
'Desde 695.00'+
'REQUISITOS:'+
'- Pasaporte Vigente (no vencer en los próximos 6 meses del viaje)'+
'- Visa Peruana'+
'🔹 Mayor información'+
'Tels Agencia: 2319-2338 / 2312-0381'+
'Tel: 7841-1184 (con Whatsapp)'+
'Tel: 7602-2242 (con Whatsapp)'+
'Email: info.ventas@martineztraveltours.com'+
'MARTINEZ TRAVEL & TOURS';
 
 return texto;
 }

}
