import 'package:flutter/cupertino.dart';

class ListaModel {
  int id;
  String nombre;
  String descripcion;
  String tag1;
  String tag2;
  String imagen;
  List<dynamic> fotos;

  ListaModel(
      {@required this.nombre,
      @required this.descripcion,
      @required this.tag1,
      @required this.tag2,
      @required this.imagen,
      @required this.id,
      this.fotos});
}

class CourseList {
  static List<ListaModel> list = [
    ListaModel(
        id: 0,
        nombre: "Nissan Versa 2016",
        descripcion:
            "Está propulsado por un motor 1.6 litros de cuatro cilindros que entrega 109 caballos de fuerza y 107 libras-pie de torque.",
        imagen:
            "https://imganuncios.mitula.net/nissan_versa_2016_gasolina_nissan_versa_advance_papeles_al_dia_motor_1600_1830096592573291157.jpg",
        tag1: "Costo por dia en Dolares (USD)",
        tag2: "\$\28.50"),
    ListaModel(
        id: 1,
        nombre: "Mitsubishi Lancer 2012",
        descripcion:
            "Bolsas de aire frontales multi-etapa para conductor y pasajero delantero, bolsa de aire de rodillas para conductor, cinturones de seguridad de tres puntos para todos los pasajeros, seguros en puertas traseras para niños, sistema de audio",
        tag1: "Costo por dia en Dolares (USD)",
        tag2: "\$\28.50",
        imagen:
            "https://imotorcarsearch.s3.amazonaws.com/vehicles/large/1144595_304039_2_133edf6fc3a9b362.jpg"),
    ListaModel(
        id: 2,
        nombre: "Toyota Corolla 2010",
        descripcion:
            "El tipo de carrocería de este vehículo es sedán (berlina) con 4 puertas, 5 asientos y FWD (tracción delantera). ",
        tag1: "Costo por dia en Dolares (USD)",
        tag2: "\$\28.50",
        imagen:
            "https://autosdeprimera.com/v2/wp-content/uploads/2011/08/toyota-corolla-xei-exterior-s.jpg"),
    ListaModel(
        id: 3,
        nombre: "Hyundai Elantra 2010",
        descripcion:
            "Es considerado un auto compacto de buen espacio interior y con un aspecto muy confortable en cada uno de los detalles interiores del habitáculo principal. ",
        tag1: "Costo por dia en Dolares (USD)",
        tag2: "\$\28.50",
        imagen:
            "https://static.cargurus.com/images/site/2009/10/08/13/12/2010_hyundai_elantra-pic-7842769328096699962-640x480.jpeg"),
  ];
}
