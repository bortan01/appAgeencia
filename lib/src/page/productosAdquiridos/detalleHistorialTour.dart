import 'package:flutter/material.dart';
import 'package:peliculas/src/models/tourPaquete/historialReserva_model.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/services/turs_services.dart';
import 'package:peliculas/src/utils/helper.dart';
import 'package:peliculas/src/widget/app_bar_widget.dart';
import 'package:peliculas/src/widget/chip_widget.dart';
import 'package:peliculas/src/widget/crear_bus.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class DetalleHistorialTours extends StatefulWidget {
  final Reserva reserva;
  const DetalleHistorialTours({@required this.reserva});

  @override
  _DetalleHistorialToursState createState() => _DetalleHistorialToursState();
}

class _DetalleHistorialToursState extends State<DetalleHistorialTours> {
  int pasoActual = 0;

  @override
  Widget build(BuildContext context) {
    Provider.of<TurServices>(context, listen: false);
    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        body: scrollView(context, widget.reserva));
  }

  Widget scrollView(BuildContext context, Reserva reserva) {
    return CustomScrollView(slivers: <Widget>[
      AppBarWidget(
        titulo: widget.reserva.nombreTours,
        imagen: transformarFoto(widget.reserva.foto),
        id: widget.reserva.idTours.toString(),
      ),
      new SliverList(
          delegate: new SliverChildListDelegate([
        new SizedBox(height: 10.0),
        helper.posterTitulo(
            context: context, title: widget.reserva.nombreTours),
        new SizedBox(height: 10.0),
        new Divider(color: Colors.grey, height: 20.0),
        helper.crearTitulo("Detalle de Compra"),
        _descripcionCompra(reserva.descripcionProducto),
        helper.crearTitulo("Descripción"),
        _descripcion(reserva.descripcionTur),
        helper.crearTitulo("Fecha de Salida"),
        _descripcionCompra(helper.transformarFecha(reserva.start)),
        helper.crearTitulo("Incluye"),
        listaHorizontal(tipo: TypeChip.azul, lista: reserva.incluye),
        helper.crearTitulo("Lugares de Salida"),
        listaHorizontal(tipo: TypeChip.verde, lista: reserva.lugarSalida),
        helper.crearTitulo("Requisitos"),
        listaHorizontal(tipo: TypeChip.anaranjado, lista: reserva.requisitos),
        helper.crearTitulo("No incluye"),
        listaHorizontal(tipo: TypeChip.rojo, lista: reserva.noIncluye),
        helper.crearTitulo("Asientos Seleccinados"),
        asientosByClient(context, reserva.transporte, reserva.asientosSeleccionados),
        SizedBox(height: 20.0)
      ]))
    ]);
  }

  Widget asientosByClient(BuildContext context, Transporte transporte, List<String> ocupados) {
    if ((transporte == null)) {
      return Container(
        color: Colors.red,
        child: Text("NO DATA"),
      );
    } else {
      return AbsorbPointer(
        absorbing: true,
        child: crearBus(
          context: context,
          asientosDerecho: transporte.asientoDerecho,
          asientosIzquierdos: transporte.asientoIzquierdo,
          filas: transporte.filas,
          deshabilitados: '',
          agregarAsiento: (String _, String __) => {},
          eliminarAsiento: (String _, String __) => {},
          ocupados: ocupados,
          filaTrasera: transporte.filaTrasera,
        ),
      );
    }
  }

  Widget listaHorizontal({@required TypeChip tipo, @required List<String> lista}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 11.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: lista.map((item) {
          return Container(padding: EdgeInsets.symmetric(vertical: 3.0), child: ChipWidget(text: item, type: tipo));
        }).toList(),
      ),
    );
  }

  Widget _descripcion(String descripcion) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            descripcion,
            overflow: TextOverflow.ellipsis,
            maxLines: 50,
            textAlign: TextAlign.justify,
            style: AppTheme.h6Style.copyWith(fontSize: 15, color: Colors.blueGrey),
          ),
        ),
      ],
    );
  }

  Widget _descripcionCompra(String descripcion) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0, top: 12.0),
          child: Text(
            descripcion.trim(),
            overflow: TextOverflow.ellipsis,
            maxLines: 50,
            textAlign: TextAlign.center,
            style: AppTheme.h6Style.copyWith(fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
