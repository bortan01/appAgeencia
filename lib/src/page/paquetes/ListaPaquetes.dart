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
          children: <Widget>[_swiperTarjetas(context)],
        ),
      ),
    );
  }

  _swiperTarjetas(BuildContext context) {
    ///estos son datos quemados
    final lista = listaInventada();
    final tamanioPantalla = MediaQuery.of(context).size;

    return Container(
      //color: Colors.blue,
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: tamanioPantalla.width * 0.8,
        itemHeight: tamanioPantalla.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Hero(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: FadeInImage(
                        image: NetworkImage(lista[index]['imagen']),
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        fit: BoxFit.cover,
                      ),
                    )),
                tag: lista[index]['posicion']),
          );
        },
        itemCount: lista.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }

  List listaInventada() {
    String imagen =
        'https://ik.imagekit.io/tvlk/xpe-asset/AyJ40ZAo1DOyPyKLZ9c3RGQHTP2oT4ZXW+QmPVVkFQiXFSv42UaHGzSmaSzQ8DO5QIbWPZuF+VkYVRk6gh-Vg4ECbfuQRQ4pHjWJ5Rmbtkk=/9593070784419/Big-Bus-Paris-Hop-On-Hop-Off-Tour-3d13f9f8-f228-4788-8c78-91a144a75431.jpeg?_src=imagekit&tr=q-60,c-at_max,w-720,h-512';
    List<dynamic> lista = new List<dynamic>();
    //de momento ocuparemos valores ficticios asi que inventarlos

    lista = [
      {
        'posicion': 0,
        'titulo': "Sedan",
        'subtitulo':
            "Una característica clave en un sedán es la seguridad que aporta. Los frenos antibloqueo son la primera línea de defensa ante cualquier accidente. Al momento de la colisión, las bolsas de aire pueden salvar la vida de tus pasajeros.",
        'imagen': imagen,
        'superficie': 'Auto Familiar',
        'distancia': '0 km',
      },
      {
        'posicion': 1,
        'titulo': "Camionetas",
        'subtitulo':
            "Empleado generalmente para el transporte de mercancías, un término que hoy en día se aplica a veces informalmente a distintos tipos de automóviles, en concreto pickups, vehículos todoterreno, furgonetas, monovolúmenes, y familiares.",
        'imagen': imagen,
        'superficie': '74,8 millones km²',
        'distancia': ' 57,91 millones km',
      },
      {
        'posicion': 2,
        'titulo': "Pickup",
        'subtitulo':
            "Empleado generalmente para el transporte de mercancías, y que tiene en su parte trasera una zona de carga descubierta (denominada caja, batea, balde, carrocería, platón, cama o palangana), en la cual se pueden colocar objetos grandes.",
        'imagen': imagen,
        'superficie': '460,2 millones km²',
        'distancia': '108,2 millones km',
      },
      {
        'posicion': 3,
        'titulo': "Microbus",
        'subtitulo':
            "Gran furgoneta que tiene asientos en la parte posterior para los pasajeros y ventanas a los lados.",
        'imagen': imagen,
        'superficie': '510,1 millones km²',
        'distancia': '149,6 millones km',
      },
      {
        'posicion': 4,
        'titulo': "Minivans",
        'subtitulo':
            "Ofrece características aptas para la familia, además de toda la tecnología que se podría desear en un paquete atractivo y a un precio muy conveniente.",
        'imagen': imagen,
        'superficie': '144,8 millones km²',
        'distancia': '227,9 millones km',
      },
    ];

    return lista;
  }
}
