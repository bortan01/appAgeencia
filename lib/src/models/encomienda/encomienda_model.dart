import 'dart:convert';

EncomiendaModel encomiendaModelFromJson(String str) => EncomiendaModel.fromJson(json.decode(str));

String encomiendaModelToJson(EncomiendaModel data) => json.encode(data.toJson());

class EncomiendaModel {
  EncomiendaModel({
    this.err,
    this.mensaje,
    this.product,
    this.comision,
    this.municipios,
  });

  bool err;
  String mensaje;
  List<Product> product;
  List<Comision> comision;
  List<Municipio> municipios;

  factory EncomiendaModel.fromJson(Map<String, dynamic> json) => EncomiendaModel(
        err: json["err"],
        mensaje: json["mensaje"],
        product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
        comision: List<Comision>.from(json["comision"].map((x) => Comision.fromJson(x))),
        municipios: List<Municipio>.from(json["municipios"].map((x) => Municipio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "comision": List<dynamic>.from(comision.map((x) => x.toJson())),
        "municipios": List<dynamic>.from(municipios.map((x) => x.toJson())),
      };
}

class Comision {
  Comision({
    this.idComision,
    this.porcentaje,
  });

  String idComision;
  double porcentaje;

  factory Comision.fromJson(Map<String, dynamic> json) => Comision(
        idComision: json["id_comision"],
        porcentaje: double.parse(json["porcentaje"]),
      );

  Map<String, dynamic> toJson() => {
        "id_comision": idComision,
        "porcentaje": porcentaje,
      };
}

class Municipio {
  Municipio({
    this.idMunicipio,
    this.nombreMunicipio,
    this.costoAgregado,
    this.departamento,
  });

  String idMunicipio;
  String nombreMunicipio;
  double costoAgregado;
  String departamento;

  factory Municipio.fromJson(Map<String, dynamic> json) => Municipio(
        idMunicipio: json["id_municipio"],
        nombreMunicipio: json["nombre_municipio"],
        costoAgregado: double.parse(json["costo_agregado"]),
        departamento: json["departamento"],
      );

  Map<String, dynamic> toJson() => {
        "id_municipio": idMunicipio,
        "nombre_municipio": nombreMunicipio,
        "costo_agregado": costoAgregado,
        "departamento": departamento,
      };
}

class Product {
  Product(
      {this.idProducto,
      this.nombreProducto,
      this.estadoProducto,
      this.idTarifa,
      this.idUnidadMedida,
      this.tarifa,
      this.idUnidad,
      this.unidadMedida,
      this.cantidadSeleccionada});

  String idProducto;
  String nombreProducto;
  String estadoProducto;
  String idTarifa;
  String idUnidadMedida;
  double tarifa;
  String idUnidad;
  String unidadMedida;
  int cantidadSeleccionada = 1;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        idProducto: json["id_producto"],
        nombreProducto: json["nombre_producto"],
        estadoProducto: json["estado_producto"],
        idTarifa: json["id_tarifa"],
        idUnidadMedida: json["id_unidad_medida"],
        tarifa: double.parse(json["tarifa"]),
        idUnidad: json["id_unidad"],
        unidadMedida: json["unidad_medida"],
      );

  Map<String, dynamic> toJson() => {
        "id_producto": idProducto,
        "nombre_producto": nombreProducto,
        "estado_producto": estadoProducto,
        "id_tarifa": idTarifa,
        "id_unidad_medida": idUnidadMedida,
        "tarifa": tarifa,
        "id_unidad": idUnidad,
        "unidad_medida": unidadMedida,
      };
}
