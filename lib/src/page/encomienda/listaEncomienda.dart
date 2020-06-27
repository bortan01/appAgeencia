import 'package:flutter/material.dart';

class ListaEncomienda extends StatefulWidget {
  @override
  ListaEncomiendaState createState() {
    return new ListaEncomiendaState();
  }
}

class ListaEncomiendaState extends State<ListaEncomienda>{
  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 1,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("Producto"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.producto.compareTo(b.producto));
            });
          },
          tooltip: "Para mostrar el producto",
        ),
        DataColumn(
          label: Text("Fecha"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.fecha.compareTo(b.fecha));
            });
          },
          tooltip: "Para mostrar la fecha",
        ),
         DataColumn(
          label: Text("Ver"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.fecha.compareTo(b.fecha));
            });
          },
          tooltip: "Para mostrar ver",
        ),
      ],
      rows: names
          .map(
            (name) => DataRow(
                  cells: [
                    DataCell(
                      Text(name.producto),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      Text(name.fecha),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                    IconButton(
                      icon: Icon(Icons.near_me),
                      onPressed: (){

                      },
                    ))
                  ],
                ),
          )
          .toList());

  @override
  Widget build(BuildContext context) {


    
    return Scaffold(
      appBar:new AppBar(
        backgroundColor: Theme.of(context).accentColor.withOpacity(1.0),
        title: Text('Listado de Encomienda',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      body: new Stack(
        children: <Widget>[  
          
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(image: new AssetImage("assets/img/fondoEnco.jpg"), 
              fit: BoxFit.cover,),
            ),
          ),
          SizedBox(height: 50.0),
       SingleChildScrollView(
            child: Column(
              children: <Widget>[_titulos(), bodyData()],
            ),
          )
         
       
          
          
        ],
      )
    );
  }
}

class Name {
  String producto;
  String fecha;

  Name({this.producto, this.fecha});
}

var names = <Name>[
  Name(producto: "Jeringas, Medicamentos",fecha: "20-07-2020"),
  Name(producto: "Medicamentos",fecha: "25-06-2020"),
   Name(producto: "Medicamentos",fecha: "25-06-2020"), 
   Name(producto: "Medicamentos",fecha: "25-06-2020"),
    Name(producto: "Medicamentos",fecha: "25-06-2020"),
     Name(producto: "Medicamentos",fecha: "25-06-2020"),
      Name(producto: "Jeringas",fecha: "20-06-2020"),
  Name(producto: "Medicamentos",fecha: "25-06-2020"),
   Name(producto: "Medicamentos",fecha: "25-06-2020"), 
   Name(producto: "Medicamentos",fecha: "25-06-2020"),
    Name(producto: "Medicamentos",fecha: "25-06-2020"),
     Name(producto: "Medicamentos",fecha: "25-06-2020"),
      Name(producto: "Jeringas",fecha: "20-06-2020"),
  Name(producto: "Medicamentos",fecha: "25-06-2020"),
   Name(producto: "Medicamentos",fecha: "25-06-2020"), 
   Name(producto: "Medicamentos",fecha: "25-06-2020"),
    Name(producto: "Medicamentos",fecha: "25-06-2020"),
     Name(producto: "Medicamos",fecha: "25-06-2020"),
      Name(producto: "Jeringas",fecha: "20-06-2020"),
  Name(producto: "Medicamentos",fecha: "25-06-2020"),
   Name(producto: "Medicamentos",fecha: "25-06-2020"), 
   Name(producto: "Medicamentos",fecha: "25-06-2020"),
    Name(producto: "Medicamentos",fecha: "25-06-2020"),
     Name(producto: "Medicamentos",fecha: "25-06-2020"),

];

Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Text('Historial de Encomiendas Enviadas',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ],
        ),
      ),
    );
  }