// To parse this JSON data, do
//
//     final vehiculosModel = vehiculosModelFromJson(jsonString);

import 'dart:convert';

VehiculosModel vehiculosModelFromJson(String str) => VehiculosModel.fromJson(json.decode(str));

String vehiculosModelToJson(VehiculosModel data) => json.encode(data.toJson());

class VehiculosModel {
    VehiculosModel({
        this.err,
        this.mensaje,
        this.autos,
          this.opcionesAdicionales,
    });

    bool err;
    String mensaje;
    List<Auto> autos;
    List<OpcioneAdicional> opcionesAdicionales;

    factory VehiculosModel.fromJson(Map<String, dynamic> json) => VehiculosModel(
        err: json["err"],
        mensaje: json["mensaje"],
        autos: List<Auto>.from(json["autos"].map((x) => Auto.fromJson(x))),
        opcionesAdicionales: List<OpcioneAdicional>.from(json["opcionesAdicionales"].map((x) => OpcioneAdicional.fromJson(x))),

    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "autos": List<dynamic>.from(autos.map((x) => x.toJson())),
        "opcionesAdicionales": List<dynamic>.from(opcionesAdicionales.map((x) => x.toJson())),

    };
}

class Auto {
    Auto({
        this.idvehiculo,
        this.idRentaCarFk,
        this.idmodelo,
        this.idTransmicionFk,
        this.idcategoria,
        this.placa,
        this.anio,
        this.color,
        this.puertas,
        this.pasajeros,
        this.precioDiario,
        this.descripcion,
        this.detalles,
        this.activo,
        this.kilometraje,
        this.tipoCombustible,
        this.opcAvanzadas,
        this.idtransmicion,
        this.transmision,
        this.idMarca,
        this.modelo,
        this.marca,
        this.nombreCategoria,
        this.descripcionCategoria,
        this.activoCategoria,
        this.idCliente,
        this.nombre,
        this.correo,
        this.celular,
        this.nivel,
        this.uuid,
        this.fbToken,
        this.dui,
        this.ultimaConexion,
        this.foto,
        this.galeria,
    });

    String idvehiculo;
    String idRentaCarFk;
    String idmodelo;
    String idTransmicionFk;
    String idcategoria;
    String placa;
    String anio;
    String color;
    String puertas;
    String pasajeros;
    String precioDiario;
    String descripcion;
    String detalles;
    String activo;
    String kilometraje;
    String tipoCombustible;
    List<String> opcAvanzadas;
    String idtransmicion;
    String transmision;
    String idMarca;
    String modelo;
    String marca;
    String nombreCategoria;
    String descripcionCategoria;
    String activoCategoria;
    String idCliente;
    String nombre;
    String correo;
    String celular;
    String nivel;
    String uuid;
    dynamic fbToken;
    String dui;
    dynamic ultimaConexion;
    String foto;
    List<String> galeria;

    factory Auto.fromJson(Map<String, dynamic> json) => Auto(
        idvehiculo: json["idvehiculo"],
        idRentaCarFk: json["id_rentaCarFK"],
        idmodelo: json["idmodelo"],
        idTransmicionFk: json["id_transmicionFK"],
        idcategoria: json["idcategoria"],
        placa: json["placa"],
        anio: json["anio"],
        color: json["color"],
        puertas: json["puertas"],
        pasajeros: json["pasajeros"],
        precioDiario: json["precio_diario"],
        descripcion: json["descripcion"],
        detalles: json["detalles"],
        activo: json["activo"],
        kilometraje: json["kilometraje"],
        tipoCombustible: json["tipoCombustible"],
        opcAvanzadas: List<String>.from(json["opc_avanzadas"].map((x) => x)),
        idtransmicion: json["idtransmicion"],
        transmision: json["transmision"],
        idMarca: json["id_marca"],
        modelo: json["modelo"],
        marca: json["marca"],
        nombreCategoria: json["nombre_categoria"],
        descripcionCategoria: json["descripcion_categoria"],
        activoCategoria: json["activo_categoria"],
        idCliente: json["id_cliente"],
        nombre: json["nombre"],
        correo: json["correo"],
        celular: json["celular"],
        nivel: json["nivel"],
        uuid: json["uuid"],
        fbToken: json["fbToken"],
        dui: json["dui"],
        ultimaConexion: json["ultimaConexion"],
        foto: json["foto"],
        galeria: List<String>.from(json["galeria"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "idvehiculo": idvehiculo,
        "id_rentaCarFK": idRentaCarFk,
        "idmodelo": idmodelo,
        "id_transmicionFK": idTransmicionFk,
        "idcategoria": idcategoria,
        "placa": placa,
        "anio": anio,
        "color": color,
        "puertas": puertas,
        "pasajeros": pasajeros,
        "precio_diario": precioDiario,
        "descripcion": descripcion,
        "detalles": detalles,
        "activo": activo,
        "kilometraje": kilometraje,
        "tipoCombustible": tipoCombustible,
        "opc_avanzadas": List<dynamic>.from(opcAvanzadas.map((x) => x)),
        "idtransmicion": idtransmicion,
        "transmision": transmision,
        "id_marca": idMarca,
        "modelo": modelo,
        "marca": marca,
        "nombre_categoria": nombreCategoria,
        "descripcion_categoria": descripcionCategoria,
        "activo_categoria": activoCategoria,
        "id_cliente": idCliente,
        "nombre": nombre,
        "correo": correo,
        "celular": celular,
        "nivel": nivel,
        "uuid": uuid,
        "fbToken": fbToken,
        "dui": dui,
        "ultimaConexion": ultimaConexion,
        "foto": foto,
        "galeria": List<dynamic>.from(galeria.map((x) => x)),
    };
}



class OpcioneAdicional {
    OpcioneAdicional({
        this.idserviciosOpc,
        this.nombreServicio,
        this.descripcion,
        this.precio,
        this.activo,
    });

    String idserviciosOpc;
    String nombreServicio;
    String descripcion;
    double precio;
    String activo;

    factory OpcioneAdicional.fromJson(Map<String, dynamic> json) => OpcioneAdicional(
        idserviciosOpc: json["idservicios_opc"],
        nombreServicio: json["nombre_servicio"],
        descripcion: json["descripcion"],
        precio: double.parse(json["precio"]),
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "idservicios_opc": idserviciosOpc,
        "nombre_servicio": nombreServicio,
        "descripcion": descripcion,
        "precio": precio,
        "activo": activo,
    };
}
