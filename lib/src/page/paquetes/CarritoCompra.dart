import 'package:flutter/material.dart';
import 'package:peliculas/src/models/paquete_models.dart';
//import 'package:peliculas/src/providers/peliculas_provider.dart';

class CarritoCompra extends StatefulWidget {
  @override
  _CarritoCompraState createState() => _CarritoCompraState();
}

class _CarritoCompraState extends State<CarritoCompra> {
  int pasoActual = 0;
  String dropdownValueNinos = '0';
  String dropdownValueAdultos = '0';
  String dropdownValueAncianos = '0';
  @override
  Widget build(BuildContext context) {
    final Paquete paquete = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        //backgroundColor: Colors.blueAccent,
        appBar: new AppBar(
          title: Text(
            "Carrito de Compra",
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            //_crearAppbar(paquete),

            new SliverList(
                delegate: new SliverChildListDelegate([
              new SizedBox(
                height: 10.0,
              ),
              _posterTitulo(paquete, context),
              new SizedBox(height: 10.0),
              _dropdownNino(),
              _dropdowAdulto(),
              _dropdowAnciano(),
              _totalPagp(),
              new SizedBox(height: 90.0,),
              _crearBoton()
            ]))
          ],
        ));
  }

  Widget _crearAppbar(Paquete paquete) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black54,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Text(
            paquete.title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(paquete.getBackgroudImage()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(microseconds: 150000),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _posterTitulo(Paquete paquete, BuildContext context) {
    //print(paquete.originalTitle);
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            child: ClipRRect(
              child: new Image(
                image: NetworkImage(paquete.getPosterImg()),
                height: 150,
              ),
              borderRadius: new BorderRadius.circular(20.0),
            ),
            tag: paquete.uniqueId,
          ),
          new SizedBox(
            width: 20.0,
          ),
          new Flexible(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: new Text(
                  paquete.title,
                  style: Theme.of(context).textTheme.title,
                  overflow:
                      TextOverflow.ellipsis, //por si el titulo es muy grande
                ),
              ),
              new Text(paquete.originalTitle,
                  style: Theme.of(context).textTheme.subtitle,
                  overflow: TextOverflow.ellipsis),
              new Row(
                children: <Widget>[
                  new Icon(Icons.attach_money),
                  new Text(
                    "695.00",
                    style: Theme.of(context).textTheme.title,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  List<Step> listaDeElementos(Paquete paquete) {
    List<Step> myLista = [
      new Step(
          title: new Text("Hotel"),
          content: Column(
            children: <Widget>[
              new FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  // height: especioDisponible,
                  image: AssetImage(
                    "assets/img/hotel.jpg",
                  )),
              new Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
            ],
          ),
          subtitle: new Text("Subtitulo"),
          state: StepState.complete,
          isActive: true),
      new Step(
          title: new Text("Desayuno"),
          content: Column(
            children: <Widget>[
              new FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  // height: especioDisponible,
                  image: AssetImage(
                    "assets/img/desayunos.jpg",
                  )),
              new Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
            ],
          ),
          subtitle: new Text("Subtitulo"),
          state: StepState.complete,
          isActive: true),
      new Step(
          title: new Text("Transporte"),
          content: Column(
            children: <Widget>[
              new FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  // height: especioDisponible,
                  image: AssetImage(
                    "assets/img/transporte.jpg",
                  )),
              new Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
            ],
          ),
          subtitle: new Text("Subtitulo"),
          state: StepState.complete,
          isActive: true),
      new Step(
          title: new Text("Refrigerio"),
          content: Column(
            children: <Widget>[
              new FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  // height: especioDisponible,
                  image: AssetImage(
                    "assets/img/refrigerio.jpg",
                  )),
              new Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
            ],
          ),
          subtitle: new Text("Subtitulo"),
          state: StepState.complete,
          isActive: true),
    ];
    return myLista;
  }

  Widget _dropdownNino() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Text("Niños (Menores de 12 años)"),
        ),
        new Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButton<String>(
              value: dropdownValueNinos,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              isExpanded: true,
              style: TextStyle(color: Theme.of(context).accentColor),
              underline: Container(
                height: 2,
                color: Theme.of(context).accentColor,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueNinos = newValue;
                });
              },
              items: <String>['0', '1', '2', '3', '4', '5']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: Text(value)),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  Widget _dropdowAdulto() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Text("Adultos (Entre 12 y 60 años)"),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButton<String>(
              value: dropdownValueAdultos,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              isExpanded: true,
              style: TextStyle(color: Theme.of(context).accentColor),
              underline: Container(
                height: 2,
                color: Theme.of(context).accentColor,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueAdultos = newValue;
                });
              },
              items: <String>['0', '1', '2', '3', '4', '5']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: Text(value)),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdowAnciano() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Text("Ancianos (Mayores de 60)"),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButton<String>(
              value: dropdownValueAncianos,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              isExpanded: true,
              style: TextStyle(color: Theme.of(context).accentColor),
              underline: Container(
                height: 2,
                color: Theme.of(context).accentColor,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueAncianos = newValue;
                });
              },
              items: <String>['0', '1', '2', '3', '4', '5']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: Text(value)),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearBoton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: new RaisedButton.icon(
          label: new Text("Reservar"),
          icon: new Icon(Icons.payment),
          color: Theme.of(context).accentColor,
          textColor: Theme.of(context).bottomAppBarColor,
          shape: StadiumBorder(),
          onPressed: () {}),
    );
  }

  Widget _totalPagp() {
    return new Container(
      height: 80.0,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[              
              Text("Descripcion", style: TextStyle(color: Theme.of(context).bottomAppBarColor)),
              Text("Total", style: TextStyle(color: Theme.of(context).bottomAppBarColor)),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
            children: <Widget>[              
              Text("2x Machupichu (Adulto)",  style: TextStyle(color: Theme.of(context).bottomAppBarColor,)),
              Text('€200'  , style: TextStyle(color: Theme.of(context).bottomAppBarColor)),
            ],
          )
        ],
      ),
    );
  }
}
