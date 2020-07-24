import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class PruebaList extends StatefulWidget {
  PruebaList({Key key}) : super(key: key);

  @override
  _PruebaListState createState() => _PruebaListState();
}

class _PruebaListState extends State<PruebaList> {
  AnimationController animateController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElasticInDown(
      child: SpinPerfect(
          // manualTrigger: true,

          //(optional, but mandatory if you use manualTrigger:true) This callback exposes the AnimationController used for the selected animation. Then you can call animationController.forward() to trigger the animation wherever you like manually.
          controller: (controller) => animateController = controller,
          child: Square()),
    )));
  }
}

class Square extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
    );
  }
}
