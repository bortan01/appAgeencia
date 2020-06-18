import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/vehiculo_models.dart';

class CardSwiper extends StatelessWidget {
  final List<Vehiculo> carro;

  CardSwiper({@required this.carro});

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
          carro[index].uniqueId = '${carro[index].id}-tarjeta';
          return Container(
            child: Hero(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                    child: GestureDetector(
                      onTap: (){
                        final peli = carro[index];

                        Navigator.pushNamed(context, 'detalle', arguments: peli);
                      },
                      child: FadeInImage(
                        image: NetworkImage(carro[index].getPosterImg()),
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ),
            tag: carro[index].uniqueId,
            ),
          );
        },
        itemCount: carro.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
