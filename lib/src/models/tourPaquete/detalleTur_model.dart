// To parse this JSON data, do
//
//     final detalleTur = detalleTurFromJson(jsonString);

import 'dart:convert';

DetalleTurModel detalleTurFromJson(String str) => DetalleTurModel.fromJson(json.decode(str));

String detalleTurToJson(DetalleTurModel data) => json.encode(data.toJson());

class DetalleTurModel {
  DetalleTurModel(
      {this.idTours,
      this.idCliente,
      this.asientosSeleccionados,
      this.labelAsiento,
      this.nombreProducto,
      this.total,
      this.descripcionProducto,
      this.cantidadAsientos,
      this.descripcionTurPaquete});

  int idTours;
  int idCliente;
  String asientosSeleccionados;
  String labelAsiento;
  String nombreProducto;
  double total;
  String descripcionProducto;
  int cantidadAsientos;
  String descripcionTurPaquete;

  factory DetalleTurModel.fromJson(Map<String, dynamic> json) => DetalleTurModel(
      idTours: json["id_tours"],
      idCliente: json["id_cliente"],
      asientosSeleccionados: json["asientos_seleccionados"],
      labelAsiento: json["label_asiento"],
      nombreProducto: json["nombre_producto"],
      total: json["total"].toDouble(),
      descripcionProducto: json["descripcionProducto"],
      cantidadAsientos: json["cantidad_asientos"],
      descripcionTurPaquete: json["descripcionTurPaquete"]);

  Map<String, dynamic> toJson() => {
        "id_tours": idTours.toString(),
        "id_cliente": idCliente.toString(),
        "asientos_seleccionados": asientosSeleccionados.toString(),
        "label_asiento": labelAsiento.toString(),
        "nombre_producto": nombreProducto.toString(),
        "total": total.toString(),
        "descripcionProducto": descripcionProducto,
        "cantidad_asientos": cantidadAsientos.toString(),
        "descripcionTurPaquete": descripcionTurPaquete
      };
}
