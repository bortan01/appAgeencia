import 'package:flutter/material.dart';
import 'package:peliculas/src/page/inicio/modelo/ModeloInformacion.dart';
import 'package:peliculas/src/providers/paquete_provider.dart';
import 'package:peliculas/src/widget/cource_info_widget.dart';

class ListaTours extends StatelessWidget {
  final PaqueteProvider peliculaProvider = new PaqueteProvider();
  @override
  Widget build(BuildContext context) {
    final String argumento = ModalRoute.of(context).settings.arguments;
    peliculaProvider.getPopulares();
    return Scaffold(
      appBar: appBarPaquete(argumento),
      body: _listado(context),
    );
  }

  Widget appBarPaquete(String argumento) {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: Text("Tours: " + argumento),
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
              Navigator.pushNamed(context, "DetalleTours",
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
              "https://scontent-mia3-2.xx.fbcdn.net/v/t1.0-9/120372954_1182099925524034_3899195115693516891_o.jpg?_nc_cat=109&_nc_sid=8bfeb9&_nc_ohc=NYWi1zpLH5wAX_Uwc8T&_nc_ht=scontent-mia3-2.xx&oh=0d5466767fbfaafa6770e21edcd804ad&oe=5F9ED151",
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
              "https://scontent-mia3-2.xx.fbcdn.net/v/t1.0-9/120372954_1182099925524034_3899195115693516891_o.jpg?_nc_cat=109&_nc_sid=8bfeb9&_nc_ohc=NYWi1zpLH5wAX_Uwc8T&_nc_ht=scontent-mia3-2.xx&oh=0d5466767fbfaafa6770e21edcd804ad&oe=5F9ED151"),
      CourseModel(
          id: 2,
          nombre: "¡¡VAMONOS A ORIENTE - VOLCAN DE CONCHAGUA!!!",
          descripcion:
              "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature",
          tag1: "22 DE FEBRERO DE 2020",
          tag2: "\$\348.50",
          imagen:
              "https://scontent-mia3-2.xx.fbcdn.net/v/t1.0-9/120372954_1182099925524034_3899195115693516891_o.jpg?_nc_cat=109&_nc_sid=8bfeb9&_nc_ohc=NYWi1zpLH5wAX_Uwc8T&_nc_ht=scontent-mia3-2.xx&oh=0d5466767fbfaafa6770e21edcd804ad&oe=5F9ED151"),
      CourseModel(
          id: 3,
          nombre: "Hyundai Elantra 2010",
          descripcion:
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum,",
          tag1: "DEL 4 AL 8 DE ABRIL 2020",
          tag2: "\$\21.50",
          imagen:
              "https://scontent-mia3-2.xx.fbcdn.net/v/t1.0-9/120372954_1182099925524034_3899195115693516891_o.jpg?_nc_cat=109&_nc_sid=8bfeb9&_nc_ohc=NYWi1zpLH5wAX_Uwc8T&_nc_ht=scontent-mia3-2.xx&oh=0d5466767fbfaafa6770e21edcd804ad&oe=5F9ED151"),
    ];
    return list;
  }
}
