import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/utils/helper.dart';

class Galeria extends StatelessWidget {
  final dynamic galeria;

  const Galeria({Key key, @required this.galeria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 270.0,
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: new FadeInImage(
                image: NetworkImage(transformarFoto(galeria[index])),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: galeria.length,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
        ));
  }
}
