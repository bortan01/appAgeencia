import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/paquete_models.dart';


class CardSwiperPaquete extends StatelessWidget {
  final List<Paquete> paquete;

  CardSwiperPaquete({@required this.paquete});

  @override
  Widget build(BuildContext context) {
    final tamanioPantalla = MediaQuery.of(context).size;

    return Container(
      //color: Colors.blue,
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: tamanioPantalla.width * 0.8,
        itemHeight: tamanioPantalla.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          paquete[index].uniqueId = '${paquete[index].id}-tarjeta';
          return Container(
            child: Hero(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                    child: GestureDetector(
                      onTap: (){
                        final tou = paquete[index];

                        Navigator.pushNamed(context, 'DetallePaquetes', arguments: tou);
                      },
                      child: FadeInImage(
                        image: NetworkImage(paquete[index].getPosterImg()),
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ),
            tag: paquete[index].uniqueId,
            ),
          );
        },
        itemCount: paquete.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
