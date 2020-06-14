import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valorSlider = 400.0;
  bool bloquearCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("eslider"),
      ),
      body: new Container(
        padding: EdgeInsets.only(top: 50.0 ),
        child: new Column(

          children: <Widget>[

            _crearSlider(),
            crearImagen(),
            crearCheckBox(),
            crearSwish()
          ],
        )
      ),
    );
  }

  _crearSlider() {
    return new Slider(
      activeColor: Colors.indigoAccent,
        label: "tamanio de la imageen",
        //divisions: 100,
        value: _valorSlider,
         min: 10.0,
         max: 400,
         onChanged: (bloquearCheck)? null :  (valor){
          setState(() {
            _valorSlider = valor;
          });
         }
    );
  }

  crearImagen() {
    return Expanded(
      child: Image(
        image: NetworkImage('https://www.frecuenciageek.com/wp-content/uploads/2017/11/TLR.jpg'),
        width: _valorSlider,
   //   fit: BoxFit.contain,
      ),
    );
  }

  crearCheckBox() {
//    return new Checkbox(
//        value: bloquearCheck,
//        onChanged: (valor){
//
//          setState(() {
//            bloquearCheck = valor;
//          });
//        } );

  return new CheckboxListTile(
      value: bloquearCheck,
      title: new Text("bloquear slider"),
      onChanged: (valor){
        setState(() {
          bloquearCheck = valor;
        });
      }
   );
  }

  crearSwish() {
    return new SwitchListTile(
        value: bloquearCheck,
        title: new Text("bloquear slider"),
        onChanged: (valor){
          setState(() {
            bloquearCheck = valor;
          });
        }
    );
  }
}
