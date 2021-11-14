import 'package:flutter/material.dart';
import 'package:peliculas/src/models/usuarios/signUp_model.dart';
import 'package:peliculas/src/services/user_services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:peliculas/src/utils/helper.dart' as helper;

class Registro extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<Registro> {
  double screenHeight;

  String _nombre = "";
  String _correo = "";
  String _password = "";
  String _password2 = "";
  bool _guardando = false;
  bool _ocultarPassword1 = true;
  bool _ocultarPassword2 = true;
  final formKey = GlobalKey<FormState>();
  UserServices _userServices = new UserServices();
  TextEditingController duiController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  MaskTextInputFormatter maskDui = MaskTextInputFormatter(mask: "########-#", filter: {"#": RegExp(r'[0-9]')});
  MaskTextInputFormatter maskCelular =
      MaskTextInputFormatter(mask: "(+###) ####-####", filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();
    duiController.text = "";
    celularController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBarAlquiler(),
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

  Widget appBarAlquiler() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Crear Cuenta"),
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
            style: TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      child: Text(
                        "Crear Cuenta",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _inputNombre(),
                    SizedBox(
                      height: 20,
                    ),
                    _inputCorreo(),
                    SizedBox(
                      height: 20,
                    ),
                    _inputPassword(),
                    SizedBox(
                      height: 20,
                    ),
                    _inputRepetirPassoword(),
                    SizedBox(
                      height: 20,
                    ),
                    _inputCelular(),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _inputDui(),
                    _inputBoton(),
                    _inputLogin(),
                  ],
                ),
              ),
            ),
          ),
        ),
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
    return new TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.text,
      autofocus: false,
      //envia un paramettro inplicito
      validator: (value) => helper.betweenLengthRequired(value, 40, 3),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Nombre Completo',
        labelText: 'Digite su Nombre Completo',
        helperText: 'Nombre Completo',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.supervised_user_circle),
      ),
      onChanged: (String persona) {
        _nombre = persona;
        setState(() {});
      },
    );
  }

  Widget _inputCorreo() {
    return new TextFormField(
      //envia un paramettro inplicito
      validator: (value) => helper.isMailRequired(value),
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Email',
        labelText: 'Digite su Email',
        helperText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.email),
      ),
      onChanged: (String value) {
        _correo = value;
        setState(() {});
      },
    );
  }

  Widget _inputPassword() {
    return new TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      obscureText: _ocultarPassword1,
      validator: (value) => helper.betweenLengthRequired(value, 20, 8),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Contraseña',
        labelText: 'Digite su Contraseña',
        helperText: 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: GestureDetector(
          child: Icon(Icons.remove_red_eye),
          onTap: () {
            setState(() {
              _ocultarPassword1 = !_ocultarPassword1;
            });
          },
        ),
      ),
      onChanged: (String value) {
        _password = value;
        setState(() {});
      },
    );
  }

  Widget _inputRepetirPassoword() {
    return new TextFormField(
      obscureText: _ocultarPassword2,
      autofocus: false,
      validator: (value) => helper.repeatPassword(_password, _password2),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Repita su Password',
        labelText: 'Repita su Password',
        helperText: 'Password',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: GestureDetector(
          child: Icon(Icons.remove_red_eye),
          onTap: () {
            setState(() {
              _ocultarPassword2 = !_ocultarPassword2;
            });
          },
        ),
      ),
      onChanged: (String value) {
        _password2 = value;
        setState(() {});
      },
    );
  }

  Widget _inputDui() {
    return new TextFormField(
      inputFormatters: [maskDui],
      keyboardType: TextInputType.number,
      validator: (value) => helper.minLength(value, 10),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: '12345678-9',
        labelText: 'Digite su Dui (opcional)',
        helperText: 'Contraseña',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.credit_card),
      ),
      onChanged: (String value) {
        duiController.text = value;
        setState(() {});
      },
    );
  }

  Widget _inputCelular() {
    return new TextFormField(
      inputFormatters: [maskCelular],
      keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
      validator: (value) => helper.minLength(value, 8),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite su Célular (opcional)',
        labelText: 'Digite su Célular (opcional)',
        helperText: 'Contraseña',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: Icon(Icons.phone),
      ),
      onChanged: (String value) {
        celularController.text = value;
        setState(() {});
      },
    );
  }

  Widget _inputLogin() {
    return new FlatButton(
      child: Text(
        '¿Ya tienes cuenta?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'login');
      },
    );
  }

  Widget _inputBoton() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: new FlatButton(
        child: (_guardando) ? CircularProgressIndicator() : Text("Crear Cuenta"),
        color: Colors.blue,
        textColor: Colors.white,
        padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        onPressed: (_guardando) ? null : _guardar,
      ),
    );
  }

  void _guardar() async {
    if (formKey.currentState.validate()) {
      //para ejecutar el on save
      setState(() {
        _guardando = true;
      });
      formKey.currentState.save();
      final signUp = new SignUpModel(
          nombre: _nombre.trim(),
          correo: _correo.trim(),
          password: _password.trim(),
          celular: celularController.text,
          dui: duiController.text,
          nivel: 'CLIENTE');
      var respuesta = await _userServices.registrarUsuario(signUp);
      setState(() {
        _guardando = false;
      });
      if (respuesta['err']) {
        ///si hay errores los imprimiremos con el Alert
        helper.mostrarMensanjeError(context, respuesta['mensaje']);
      } else {
        //si se guardo redireccionaremos al login
        _limpiar();
        Alert(
          context: context,
          type: AlertType.success,
          title: "Listo",
          desc: respuesta['mensaje'],
          closeFunction: () => Navigator.pushReplacementNamed(context, 'login'),
          buttons: [
            DialogButton(
              child: Text(
                "ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
              color: Color.fromRGBO(0, 179, 134, 1.0),
            )
          ],
        ).show();
      }
    }

    // Navigator.pushNamed(context, 'login');
  }

  void _limpiar() {
    setState(() {
      _nombre = "";
      _correo = "";
      _password = "";
      _password2 = "";
      celularController.text = "";
      duiController.text = "";
    });
  }
}
