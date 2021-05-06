import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/vehiculo/vehiculosAlquilados_model.dart';
import 'package:peliculas/src/widget/app_bar_widget.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/widget/chip_widget.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class DetalleHistorialVehiculos extends StatelessWidget {
  DetalleHistorialVehiculos();
  @override
  Widget build(BuildContext context) {
    final HistorialDetalle carro = ModalRoute.of(context).settings.arguments;

    final String myTitulo = '${carro.modelo} ${carro.modelo} ${carro.anio}';
    return Scaffold(
      backgroundColor: Colors.white,
      body: new CustomScrollView(
        slivers: <Widget>[
          AppBarWidget(
              titulo: myTitulo,
              imagen: helper.transformarFoto(carro.foto),
              //ES NECESARIO EL ID PARA LA ANIMACION
              id: carro.idvehiculo),
          new SliverList(
              delegate: new SliverChildListDelegate([
            new SizedBox(height: 10.0),
            helper.posterTitulo(context: context, title: myTitulo),
            _descripcion("", carro.descripcion),
            _cuadros(carro),
            helper.crearTitulo("Otras Opciones"),
            _otrasOpciones(carro.opcAvanzadas),
            _adicional(carro),
            _descripcion('Informacion Adicional', carro.detalles),
            _swiperTarjetas(context, carro.galeria),
          ]))
        ],
      ),
    );
  }
}

Widget _descripcion(String titulo, String descripcion) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 15),
      (titulo.isNotEmpty)
          ? Container(
              margin: EdgeInsets.only(left: 15.0, bottom: 5.0),
              child: Center(child: Text(titulo, style: helper.titulo2())),
            )
          : Container(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Text(descripcion,
            overflow: TextOverflow.ellipsis,
            maxLines: 50,
            textAlign: TextAlign.justify,
            style: AppTheme.h6Style.copyWith(fontSize: 15, color: Colors.blueGrey)),
      ),
    ],
  );
}

Widget _cuadros(HistorialDetalle carro) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(31),
        topRight: Radius.circular(31),
      ),
      color: Colors.white,
    ),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyIconButton(
                buttonText: carro.tipoCombustible,
                buttonIcon: Icons.games,
              ),
              MyIconButton(
                buttonText: carro.transmision,
                buttonIcon: Icons.drive_eta,
              ),
              MyIconButton(
                buttonText: '${carro.puertas} Puertas',
                buttonIcon: Icons.home,
              ),
              MyIconButton(
                buttonText: '${carro.pasajeros} Pasajeros',
                buttonIcon: Icons.event_seat,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _otrasOpciones(List<String> opcAvanzadas) {
  List<Widget> opcionesList = [];

  opcAvanzadas.forEach((opcion) {
    opcionesList.add(ChipWidget(text: opcion, type: TypeChip.azul));
    opcionesList.add(SizedBox(height: 5.0));
  });

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 11.0, vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: opcionesList,
    ),
  );
}

Widget _adicional(HistorialDetalle carro) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 41.0, vertical: 15.0),
    margin: EdgeInsets.only(left: 11.0, right: 11.0, top: 10.0, bottom: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
        bottomLeft: Radius.circular(18),
        bottomRight: Radius.circular(18),
      ),
      color: Colors.grey[200],
    ),
    child: Column(
      children: <Widget>[
        Text(
          "Servicios Adicionales Seleccionados",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        new Column(
          children: carro.servicios.map((item) => _item(servicio: item)).toList(),
        ),
      ],
    ),
  );
}

_swiperTarjetas(BuildContext context, List<String> galery) {
  ///estos son datos quemados
  final tamanioPantalla = MediaQuery.of(context).size;

  return Container(
    //color: Colors.blue,
    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
    child: Swiper(
      layout: SwiperLayout.STACK,
      itemWidth: tamanioPantalla.width * 0.8,
      itemHeight: tamanioPantalla.height * 0.5,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () {},
                child: FadeInImage(
                  image: NetworkImage(helper.transformarFoto(galery[index])),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              )),
        );
      },
      itemCount: galery.length,
      // pagination: new SwiperPagination(),
      // control: new SwiperControl(),
    ),
  );
}

Widget _item({Servicio servicio}) {
  double total = int.parse(servicio.cantidadServicio) * double.parse(servicio.costoServicio);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(11),
        margin: EdgeInsets.all(11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFF009ff7),
        ),
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${servicio.cantidadServicio} X  ${servicio.servicioAdicional}',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Precio: ${servicio.costoServicio} c/u',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
            Text(
              'Total: ${total.toStringAsFixed(2)}',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class MyIconButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  const MyIconButton({Key key, this.buttonText, this.buttonIcon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: Icon(
              buttonIcon,
              color: Color(0xFF009ff7),
            ),
          ),
          Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
