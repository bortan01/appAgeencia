// To parse this JSON data, do
//
//     final categoriaModel = categoriaModelFromJson(jsonString);

import 'dart:convert';

CategoriaModel categoriaModelFromJson(String str) => CategoriaModel.fromJson(json.decode(str));

String categoriaModelToJson(CategoriaModel data) => json.encode(data.toJson());

class CategoriaModel {
    CategoriaModel({
        this.err,
        this.mensaje,
        this.categorias,
    });

    bool err;
    String mensaje;
    List<Categoria> categorias;

    factory CategoriaModel.fromJson(Map<String, dynamic> json) => CategoriaModel(
        err: json["err"],
        mensaje: json["mensaje"],
        categorias: List<Categoria>.from(json["categorias"].map((x) => Categoria.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "categorias": List<dynamic>.from(categorias.map((x) => x.toJson())),
    };
}

class Categoria {
    Categoria({
        this.idcategoria,
        this.nombreCategoria,
        this.descripcionCategoria,
        this.activoCategoria,
    });

    String idcategoria;
    String nombreCategoria;
    String descripcionCategoria;
    String activoCategoria;

    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        idcategoria: json["idcategoria"],
        nombreCategoria: json["nombre_categoria"],
        descripcionCategoria: json["descripcion_categoria"],
        activoCategoria: json["activo_categoria"],
    );

    Map<String, dynamic> toJson() => {
        "idcategoria": idcategoria,
        "nombre_categoria": nombreCategoria,
        "descripcion_categoria": descripcionCategoria,
        "activo_categoria": activoCategoria,
    };
}
