import 'package:flutter/material.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/widget/cource_info_widget.dart';

class ToursAsistidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPaquete(),
      body: _listado(context),
    );
  }

  Widget appBarPaquete() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Historial de viajes"),
    );
  }

  Widget _listado(BuildContext context) {
    List<CourseModel> miListaPaquetes = listaInventada();
    //Posiblemente esto se convierta en futureBilder
    return ListView.builder(
        itemCount: miListaPaquetes.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "DetallePaquetes",
                  arguments: miListaPaquetes[index]);
            },
            child: Column(
              children: <Widget>[
                ///AQUI ES DONDE SE CREAN LAS IMAGENES
                CourceInfoWidget(model: miListaPaquetes[index]),
                //ESTA ES LA LINEA DE ABAJO
                Divider(
                  thickness: 1,
                  endIndent: 20,
                  indent: 20,
                )
              ],
            ),
          );
        });
  }

  List<CourseModel> listaInventada() {
    final List<CourseModel> list = [
      CourseModel(
          id: 0,
          nombre: "!VAMONOS A COSTA RICA¡",
          descripcion:
              "Lorem Ipsum is simply dummy text of theSy. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has",
          imagen:
              "https://scontent-mia3-1.xx.fbcdn.net/v/t1.0-9/86437795_990747354659293_6900039684588568576_o.jpg?_nc_cat=111&_nc_sid=8bfeb9&_nc_ohc=7C_YX7hStUoAX8L4gfs&_nc_ht=scontent-mia3-1.xx&oh=7011c279fc4440049946ee3885011486&oe=5F3D9421",
          tag1: "DEL 4 AL 9 DE ABRIL 2019",
          tag2: "\$\28.50"),
      CourseModel(
          id: 1,
          nombre: "VÁMONOS A PANAMÁ (POR TIERRA)",
          descripcion:
              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. ",
          tag1: "DEL 4 AL 12 DE ABRIL 2020",
          tag2: "\$\348.50",
          imagen:
              "https://scontent-mia3-2.xx.fbcdn.net/v/t1.0-9/84811539_986682118399150_14819376632954880_o.jpg?_nc_cat=110&_nc_sid=8bfeb9&_nc_ohc=DaYgZfeMq4IAX9LlsJz&_nc_oc=AQleHmuMwN8IEQ6XZ8qOp785dw0Dv7WovH8apQb2RmJkOG3tDaWlQweXn4MGH28-F4c&_nc_ht=scontent-mia3-2.xx&oh=ec094f10f32ce5e6a69f51fa668a4c0e&oe=5F3F29BE"),
      CourseModel(
          id: 2,
          nombre: "¡¡VAMONOS A ORIENTE - VOLCAN DE CONCHAGUA!!!",
          descripcion:
              "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature",
          tag1: "22 DE FEBRERO DE 2020",
          tag2: "\$\348.50",
          imagen:
              "https://scontent-mia3-1.xx.fbcdn.net/v/t1.0-9/83469740_980152025718826_5435872388350738432_o.jpg?_nc_cat=104&_nc_sid=730e14&_nc_ohc=C_36jJc6AzUAX_DXxQM&_nc_ht=scontent-mia3-1.xx&oh=3d06f03116be2b6e2298b4ed8f98f955&oe=5F3F529D"),
      CourseModel(
          id: 3,
          nombre: "Hyundai Elantra 2010",
          descripcion:
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum,",
          tag1: "DEL 4 AL 8 DE ABRIL 2020",
          tag2: "\$\21.50",
          imagen:
              "https://scontent-mia3-2.xx.fbcdn.net/v/t1.0-9/83353671_979272542473441_6245999208600436736_o.jpg?_nc_cat=110&_nc_sid=730e14&_nc_ohc=cgSXXxAVhBEAX-ZsmDl&_nc_ht=scontent-mia3-2.xx&oh=2bd55e51f9fa0dc03ee5ac6b71f2767f&oe=5F3FFC91"),
    ];
    return list;
  }
}
