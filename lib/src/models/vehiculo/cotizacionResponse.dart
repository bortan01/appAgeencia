// To parse this JSON data, do
//
//     final cotizacionResponse = cotizacionResponseFromJson(jsonString);

import 'dart:convert';

CotizacionResponse cotizacionResponseFromJson(String str) => CotizacionResponse.fromJson(json.decode(str));

String cotizacionResponseToJson(CotizacionResponse data) => json.encode(data.toJson());

class CotizacionResponse {
    CotizacionResponse({
        this.err,
        this.mensaje,
        this.cotizacionId,
    });

    bool err;
    String mensaje;
    int cotizacionId;

    factory CotizacionResponse.fromJson(Map<String, dynamic> json) => CotizacionResponse(
        err: json["err"],
        mensaje: json["mensaje"],
        cotizacionId: json["cotizacion_id"],
    );

    Map<String, dynamic> toJson() => {
        "err": err,
        "mensaje": mensaje,
        "cotizacion_id": cotizacionId,
    };
}
