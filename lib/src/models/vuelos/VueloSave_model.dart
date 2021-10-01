// To parse this JSON data, do
//
//     final vueloSaveModel = vueloSaveModelFromJson(jsonString);

import 'dart:convert';

VueloSaveModel vueloSaveModelFromJson(String str) => VueloSaveModel.fromJson(json.decode(str));

String vueloSaveModelToJson(VueloSaveModel data) => json.encode(data.toJson());

class VueloSaveModel {
    VueloSaveModel({
        this.idCliente,
        this.ciudadPartida,
        this.fechaPartida,
        this.horaPartida,
        this.ciudadLlegada,
        this.fechaLlegada,
        this.horaLlegada,
        this.adultos,
        this.ninos,
        this.bebes,
        this.maletas,
        this.idaerolinea,
        this.idclase,
        this.idtipoViaje,
        this.detallePasajero,
        this.opcAvanzadas,
    });

    String idCliente;
    String ciudadPartida;
    String fechaPartida;
    String horaPartida;
    String ciudadLlegada;
    String fechaLlegada;
    String horaLlegada;
    String adultos;
    String ninos;
    String bebes;
    String maletas;
    String idaerolinea;
    String idclase;
    String idtipoViaje;
    String detallePasajero;
    String opcAvanzadas;

    factory VueloSaveModel.fromJson(Map<String, dynamic> json) => VueloSaveModel(
        idCliente: json["id_cliente"],
        ciudadPartida: json["ciudad_partida"],
        fechaPartida: json["fechaPartida"],
        horaPartida: json["HoraPartida"],
        ciudadLlegada: json["ciudad_llegada"],
        fechaLlegada: json["fechaLlegada"],
        horaLlegada: json["HoraLlegada"],
        adultos: json["adultos"],
        ninos: json["ninos"],
        bebes: json["bebes"],
        maletas: json["maletas"],
        idaerolinea: json["idaerolinea"],
        idclase: json["idclase"],
        idtipoViaje: json["idtipo_viaje"],
        detallePasajero: json["detallePasajero"],
        opcAvanzadas: json["opc_avanzadas"],
    );

    Map<String, dynamic> toJson() => {
        "id_cliente": idCliente,
        "ciudad_partida": ciudadPartida,
        "fechaPartida": fechaPartida,
        "HoraPartida": horaPartida,
        "ciudad_llegada": ciudadLlegada,
        "fechaLlegada": fechaLlegada,
        "HoraLlegada": horaLlegada,
        "adultos": adultos,
        "ninos": ninos,
        "bebes": bebes,
        "maletas": maletas,
        "idaerolinea": idaerolinea,
        "idclase": idclase,
        "idtipo_viaje": idtipoViaje,
        "detallePasajero": detallePasajero,
        "opc_avanzadas": opcAvanzadas,
    };
}
