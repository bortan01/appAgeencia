import 'package:flutter/material.dart';

class FormularioAlquiler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Alquiler(),
    );
  }
} 

class Alquiler extends StatefulWidget {
  @override
  _AlquilerPageState createState() => _AlquilerPageState();
}

class _AlquilerPageState extends State<Alquiler> {

  double screenHeight;

   String _nombre = "";
    String _lugarRecogida = "";
      String _lugarRecogidaFnal = "";
  
  String opcionSeleccionada = 'Servicio a Domicilio';

  List <String> _lugar = ['Servicio a Domicilio', 'Aeropuerto', 'Ciudad', 'otros'];
  
  


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[           
            paginaFondo(),
            imagenPortada(context),
            cajaFormulario(context),
          ],
        ),
      ),
    );
  }

  Widget paginaFondo() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        
          Text(
            "",
            style: TextStyle(
                fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  Widget cajaFormulario(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Rerservar Vehículo",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  
                  SizedBox(
                    height: 15,
                  ),
                  _inputNombre(),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Numero de Telefono", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                 _crearDropdown(),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Dirección", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Fecha", hasFloatingPlaceholder: true),
                    
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Lugar de Devolución", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Dirección", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Fecha", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      
                      Expanded(
                        child: Container(),
                      ),
                      FlatButton(
                        child: Text("Reservar"),
                        color: Color(0xFF4B9DFE),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Puede completar datos adicionales en Pagina Web",
              style: TextStyle(color: Colors.grey),
            ),
            
          ],
        )
      ],
    );
  }
   Widget imagenPortada(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'assets/img/portada.png',
        fit: BoxFit.cover,
      ),
    );
  }

 
 Widget _inputNombre() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      hintText: 'Digite su Nombre',
      labelText: 'Digite su Nombre Completo',
      helperText: 'Nombre Completo', hasFloatingPlaceholder: true,
      suffixIcon: Icon(Icons.playlist_add_check),
      ),
      onChanged: (String persona) {
        _nombre = persona;
        setState(() {});
      },
    );
  }
   Widget _inputTelefono() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      hintText: 'Digite su Nombre',
      labelText: 'Digite su Nombre Completo',
      helperText: 'Nombre Completo', hasFloatingPlaceholder: true,
      suffixIcon: Icon(Icons.playlist_add_check),
      ),
      onChanged: (String persona) {
        _nombre = persona;
        setState(() {});
      },
    );
  }
   Widget _inputLugarRecogida() {
    return new TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      hintText: 'Digite su Nombre',
      labelText: 'Digite su Nombre Completo',
      helperText: 'Nombre Completo', hasFloatingPlaceholder: true,
      suffixIcon: Icon(Icons.playlist_add_check),
      ),
      onChanged: (String persona) {
        _nombre = persona;
        setState(() {});
      },
    );
  }
 



 Widget _inputRecogida() {
    return new TextField(
      // autofocus: true,
     
      textCapitalization: TextCapitalization.words,
      
      decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      hintText: 'Digite su Nombre',
      labelText: 'Digite su Nombre Completo',
      helperText: 'Nombre Completo', hasFloatingPlaceholder: true,
     
      suffixIcon: Icon(Icons.playlist_add_check),
      ),
      onChanged: (String persona) {
        _nombre = persona;
        setState(() {});
      },
    );
  }

   

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();
    _lugar.forEach((lugar) {
      lista.add(DropdownMenuItem(
        child: new Text(lugar),
        value: lugar,
      ));
    });
    return lista;
  }
   Widget _crearDropdown() {
    return DropdownButton(
      
     value: opcionSeleccionada,
     items: getOpcionesDropdown(),
     onChanged: (opc){
       setState(() {
         opcionSeleccionada = opc;
       });
     },

    );
  }
 
}