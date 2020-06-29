import 'package:flutter/material.dart';
import 'package:peliculas/src/page/vehiculos/DetalleVehiculos.dart';

class HistorialEncomienda extends StatefulWidget {
  @override
  HistorialEncomiendaState createState() {
    return new HistorialEncomiendaState();
  }
}

class HistorialEncomiendaState extends State<HistorialEncomienda> {
  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 1,
      sortAscending: true,
      columnSpacing: 130,
      columns: <DataColumn>[
        DataColumn(
          label: Text("Información",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.mensaje.compareTo(b.mensaje));
            });
          },
          tooltip: "Para mostrar el producto",
        ),
        DataColumn(
          label: Text("Fecha",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.fecha.compareTo(b.fecha));
            });
          },
          tooltip: "Para mostrar la fecha",
        ),
      ],
      rows: names
          .map(
            (name) => DataRow(
              cells: [
                DataCell(
                  Text(name.mensaje),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(name.fecha),
                  showEditIcon: false,
                  placeholder: false,
                ),
              ],
            ),
          )
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Theme.of(context).accentColor.withOpacity(1.0),
          title: Text('Historial Encomienda',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/img/fondoEnco.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 50.0),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[_titulos(), bodyData()],
              ),
            )
          ],
        ));
  }
}

class Name {
  String mensaje;
  String fecha;

  Name({this.mensaje, this.fecha});
}

var names = <Name>[
  Name(mensaje: "Esta bien el envio", fecha: "20-07-2020"),
  Name(mensaje: "Sigue  bien el envio", fecha: "25-07-2020"),
  Name(mensaje: "creemos que Sigue bien el envio", fecha: "26-07-2020"),
];

Widget _titulos() {
  return SafeArea(
      child: Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(11.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyIconButton(
              buttonText: "Se recibió información",
              buttonIcon: Icons.add_alert,
            ),
            MyIconButton(
              buttonText: "En tránsito",
              buttonIcon: Icons.airport_shuttle,
            ),
            MyIconButton(
              buttonText: "Entregado",
              buttonIcon: Icons.cancel,
            ),
          ],
        ),
      )
    ],
  ));
}
