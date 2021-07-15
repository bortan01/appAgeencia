import 'package:flutter/material.dart';

class AboutAsPage extends StatelessWidget {
  const AboutAsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('Acerca de Nosotros'),
      ),
      body: ListView(
        children: <Widget>[
          _imagen(),
          _tarjetaDetalle(
            context: context,
            icono: Icons.info,
            titulo: '¿Quíenes somos?',
            descripcion:
                'La agencia de viajes surge en el año 2009 como un negocio familiar, realizando excursiones nacionales y en Centroamérica, vía terrestre, orientados desde un principio en la calidad, seguridad, además del profesionalismo en cada uno de sus tours, promoviendo paquetes turísticos a lo largo de todo el mundo, realizando circuitos en más de 20 países incluyendo tanto Europeos como Asiáticos, gracias al éxito obtenido en cada uno de esos viajes surge lo que hoy en día es una agencia de viajes llamada MARTINEZ TRAVEL & TOURS siendo de alta calidad y completos los servicios que ofrecen a sus clientes.',
          ),
          _tarjetaDetalle(
            context: context,
            icono: Icons.phone,
            titulo: 'Teléfono',
            descripcion: '7841 - 1184',
          ),
          _tarjetaDetalle(
            context: context,
            icono: Icons.mail,
            titulo: 'Correo',
            descripcion: 'info.ventas@martineztraveltours.com',
          ),
          _tarjetaDetalle(
            context: context,
            icono: Icons.language,
            titulo: 'Web',
            descripcion: 'www.martineztraveltours.com',
          ),
          SizedBox(height: 30.0)
        ],
      ),
    );
  }

  Widget _tarjetaDetalle({BuildContext context, String titulo, IconData icono, String descripcion}) {
    return new Container(
        padding: EdgeInsets.all(5.0),
        margin: new EdgeInsets.only(
          top: 15.0,
          right: 20.0,
          left: 20.0,
        ),
        decoration: new BoxDecoration(
          color: Color(0xFF4B9DFE),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(4.0),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black12, blurRadius: 10.0, offset: Offset(0.0, 8.0))
          ], /* Aplica sombra */
        ),
        child: Container(
          /* Margen del contenido */
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Icon(icono, color: Colors.white),
                    margin: EdgeInsets.all(5.0),
                  ),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    child: new Text(titulo,
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                        overflow: TextOverflow.ellipsis),
                  ),
                  new SizedBox(height: 5.0),
                ],
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: Text(
                  descripcion,
                  maxLines: 20,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _imagen() {
    return new Container(
      child: Image(
        image: AssetImage('assets/img/icon.png'),
        height: 300.0,
      ),
    );
  }
}
