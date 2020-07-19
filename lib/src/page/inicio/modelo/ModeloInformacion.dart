class CourseModel {
  String nombre;
  String descripcion;
  String tag1;
  String tag2;

  CourseModel({this.nombre, this.descripcion, this.tag1, this.tag2});
}

class CourseList {
  static List<CourseModel> list = [
    CourseModel(
        nombre: "Nissan Versa 2016",
        descripcion:
            "Está propulsado por un motor 1.6 litros de cuatro cilindros que entrega 109 caballos de fuerza y 107 libras-pie de torque.",
        tag1: "Costo por dia en Dolares (USD)",
        tag2: "28.50"),
    CourseModel(
        nombre: "Mitsubishi Lancer 2012",
        descripcion:
            "Bolsas de aire frontales multi-etapa para conductor y pasajero delantero, bolsa de aire de rodillas para conductor, cinturones de seguridad de tres puntos para todos los pasajeros, seguros en puertas traseras para niños, sistema de audio",
        tag1: "Costo por dia en Dolares (USD)",
        tag2: "28.50"),
    CourseModel(
        nombre: "Toyota Corolla 2010",
        descripcion:
            "El tipo de carrocería de este vehículo es sedán (berlina) con 4 puertas, 5 asientos y FWD (tracción delantera). ",
        tag1: "Costo por dia en Dolares (USD)",
        tag2: "28.50"),
    CourseModel(
        nombre: "Hyundai Elantra 2010",
        descripcion:
            "Es considerado un auto compacto de buen espacio interior y con un aspecto muy confortable en cada uno de los detalles interiores del habitáculo principal. ",
        tag1: "Costo por dia en Dolares (USD)",
        tag2: "28.50"),
  ];
}
