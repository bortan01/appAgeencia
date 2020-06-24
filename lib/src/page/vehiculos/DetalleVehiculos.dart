import 'package:flutter/material.dart';
import 'package:peliculas/src/page/vehiculos/HomeCategoria.dart';

class DetalleVehiculos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          subhead: TextStyle(color: Colors.white54),
          body1: TextStyle(color: Colors.white54),
          subtitle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          title: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF009ff7),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  SizedBox(height: 11),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Hyundai Elantra 2020",
                              style: Theme.of(context).textTheme.headline,
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 9.0, vertical: 5.0),
                              color: Colors.white12,
                              child: Text("Depósito de combustible lleno"),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 3.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(5.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_shopping_cart,
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Divider(
                    color: Colors.white54,
                  ),
                  SizedBox(height: 5),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "\Costo diario:",
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        Text(
                          "\$28.50",
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        
                      ],
                    ),
                  ),
                  SizedBox(height: 11),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white30,
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeCategoria()),);
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
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 11),
                ],
              ),
            ),
            Expanded(
              child: Container(
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
                            buttonText: "Gasolina",
                            buttonIcon: Icons.drive_eta,
                          ),
                          MyIconButton(
                            buttonText: "Automatico",
                            buttonIcon: Icons.drive_eta,
                          ),
                          MyIconButton(
                            buttonText: "4 Puertas",
                            buttonIcon: Icons.home,
                          ),
                          MyIconButton(
                            buttonText: "5 Pasajeros",
                            buttonIcon: Icons.event_seat,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
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
                            Expanded(
                              child: ListView.builder(
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(11),
                                        margin: EdgeInsets.all(11),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color(0xFF009ff7),
                                        ),
                                        child: Icon(
                                          Icons.wifi,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Wifi Móvil",
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                            Text(
                                              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Natus, enim hic.",
                                              style: TextStyle(
                                                  color: Colors.black45),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyIconButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  const MyIconButton({Key key, this.buttonText, this.buttonIcon})
      : super(key: key);
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