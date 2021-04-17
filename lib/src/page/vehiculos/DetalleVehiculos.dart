import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/vehiculo/vehiculo_model.dart';
import 'package:peliculas/src/widget/app_bar_widget.dart';
import 'package:peliculas/src/page/Temas/Temas.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class DetalleVehiculos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auto carro = ModalRoute.of(context).settings.arguments;
    final String myTitulo = '${carro.marca} ${carro.modelo} ${carro.anio}';
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
            new SizedBox(
              height: 10.0,
            ),
            _posterTitulo(
                context: context,
                titulo: myTitulo,
                subtitulo: carro.descripcion,
                imagen:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQG356LIbLadfZO3JsJcNpCSwBrotB57G35xQ&usqp=CAU",
                precio: "28.50",
                id: int.parse(carro.idvehiculo)),
            _descripcion(carro.descripcion),
            _cuadros(carro),
            _botones(context),
            _adicional(),
            _swiperTarjetas(context, carro.galeria),
          ]))
        ],
      ),
    );
  }
}

_posterTitulo({BuildContext context, String titulo, String subtitulo, String precio, String imagen, int id}) {
  return new Container(
    child: Row(
      children: <Widget>[
        // ClipRRect(
        //   child: new Image(
        //     image: NetworkImage(imagen),
        //     height: 100,
        //     width: 125,
        //   ),
        //   borderRadius: new BorderRadius.circular(20.0),
        // ),
        new SizedBox(
          width: 10.0,
        ),
        new Flexible(
            child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // new Text(
            //   titulo,
            //   style: TextStyle(
            //     fontSize: 20,
            //     color: Colors.black,
            //   ),
            //   overflow: TextOverflow.ellipsis, //por si el titulo es muy grande
            // ),

            // new Text(subtitulo,
            //     //maxLines: 4,
            //     style: TextStyle(
            //       fontSize: 12,
            //       color: Colors.blueAccent,
            //     ),
            //     overflow: TextOverflow.ellipsis),
            new Row(
              children: <Widget>[
                new Text(
                  '\$$precio',
                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800),
                ),
                new Text(
                  '/Día',
                  style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ))
      ],
    ),
  );
}

Container _botones(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10.0),
    decoration: BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(35),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.call_received,
                color: Colors.white,
              ),
              Text(
                "Ver Flota de Vehiculos",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Container(
          height: 30,
          width: 1,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.white54,
                width: 3.0,
              ),
            ),
          ),
        ),
        FlatButton(
          child: Row(
            children: <Widget>[
              Text(
                "Reservar",
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.call_made,
                color: Colors.white,
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'Alquiler');
          },
        ),
      ],
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
        child: Text(descripcion,
            overflow: TextOverflow.ellipsis,
            maxLines: 50,
            textAlign: TextAlign.justify,
            style: AppTheme.h6Style.copyWith(fontSize: 15, color: Colors.blueGrey)),
      ),
    ],
  );
}

Widget _cuadros(Auto carro) {
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

Widget _adicional() {
  return Container(
    padding: EdgeInsets.all(11.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(31),
        topRight: Radius.circular(31),
      ),
      color: Colors.grey[200],
    ),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Adicional: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            FlatButton(
              child: Text(
                "",
                style: TextStyle(
                  color: Color(0xFF009ff7),
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
        _item(icono: Icons.check_circle, titulo: "Wifi", descripcion: ""),
        _item(icono: Icons.check_circle, titulo: "Sonido", descripcion: ""),
        _item(icono: Icons.check_circle, titulo: "Otro", descripcion: ""),
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

List listaInventada() {
  String imagen =
      'https://ik.imagekit.io/tvlk/xpe-asset/AyJ40ZAo1DOyPyKLZ9c3RGQHTP2oT4ZXW+QmPVVkFQiXFSv42UaHGzSmaSzQ8DO5QIbWPZuF+VkYVRk6gh-Vg4ECbfuQRQ4pHjWJ5Rmbtkk=/9593070784419/Big-Bus-Paris-Hop-On-Hop-Off-Tour-3d13f9f8-f228-4788-8c78-91a144a75431.jpeg?_src=imagekit&tr=q-60,c-at_max,w-720,h-512';
  List<dynamic> lista = new List<dynamic>();
  //de momento ocuparemos valores ficticios asi que inventarlos

  lista = [
    {
      'posicion': 0,
      'titulo': "Sedan",
      'subtitulo':
          "Una característica clave en un sedán es la seguridad que aporta. Los frenos antibloqueo son la primera línea de defensa ante cualquier accidente. Al momento de la colisión, las bolsas de aire pueden salvar la vida de tus pasajeros.",
      'imagen': imagen,
      'superficie': 'Auto Familiar',
      'distancia': '0 km',
    },
    {
      'posicion': 1,
      'titulo': "Camionetas",
      'subtitulo':
          "Empleado generalmente para el transporte de mercancías, un término que hoy en día se aplica a veces informalmente a distintos tipos de automóviles, en concreto pickups, vehículos todoterreno, furgonetas, monovolúmenes, y familiares.",
      'imagen': imagen,
      'superficie': '74,8 millones km²',
      'distancia': ' 57,91 millones km',
    },
    {
      'posicion': 2,
      'titulo': "Pickup",
      'subtitulo':
          "Empleado generalmente para el transporte de mercancías, y que tiene en su parte trasera una zona de carga descubierta (denominada caja, batea, balde, carrocería, platón, cama o palangana), en la cual se pueden colocar objetos grandes.",
      'imagen': imagen,
      'superficie': '460,2 millones km²',
      'distancia': '108,2 millones km',
    },
    {
      'posicion': 3,
      'titulo': "Microbus",
      'subtitulo': "Gran furgoneta que tiene asientos en la parte posterior para los pasajeros y ventanas a los lados.",
      'imagen': imagen,
      'superficie': '510,1 millones km²',
      'distancia': '149,6 millones km',
    },
    {
      'posicion': 4,
      'titulo': "Minivans",
      'subtitulo':
          "Ofrece características aptas para la familia, además de toda la tecnología que se podría desear en un paquete atractivo y a un precio muy conveniente.",
      'imagen': imagen,
      'superficie': '144,8 millones km²',
      'distancia': '227,9 millones km',
    },
  ];

  return lista;
}

Widget _item({IconData icono, String titulo, String descripcion}) {
  return Row(
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(11),
        margin: EdgeInsets.all(11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFF009ff7),
        ),
        child: Icon(
          icono,
          color: Colors.white,
        ),
      ),
      SizedBox(
        width: 5.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              titulo,
              style: TextStyle(color: Colors.black87),
            ),
            Text(
              descripcion,
              style: TextStyle(color: Colors.black45),
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
