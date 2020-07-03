class CourseModel {
  String nombre;
  String descripcion;
  String tag1;
  String tag2;

  CourseModel(
      {this.nombre,
      this.descripcion,
      this.tag1,
      this.tag2});
}

class CourseList {
  static List<CourseModel> list = [
    CourseModel(
        nombre: "Paquetes",
        descripcion:
            "Te llevamos donde tu quieras! Tenemos para tí paquetes vacacionales especiales para que viajes cuando quieras a donde quieras.",
        tag1: "Nacionales",
        tag2: "Internacionales"),
    CourseModel(
        nombre: "Tours",
        descripcion:
            "Encuentra los mejores tours y actividades en tu destino. Explora el mundo con nuestra Agencia y viaja sin preocupaciones.",
        tag1: "Nacionales",
        tag2: "Internacionales"),
    CourseModel(
        nombre: "Vehículos",
        descripcion:
            "Precio Más Bajo Garantizado! Reserva Online Ahora.",
        tag1: "Aeropuerto",
        tag2: "Entrega a domicilio"),
        CourseModel(
        nombre: "Encomiendas",
        descripcion:
            "Con el servicio de envío Puerta a Puerta reciba su encomienda en la comodidad de su hogar, o a la oficina más cercana a su residencia en El Salvador.",
        tag1: "Cotización",
        tag2: "Estado de Envío"),
  ];
}