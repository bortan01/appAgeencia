// import 'package:flutter/material.dart';
part of 'helper.dart';

Route navegarMapaFadeIn(BuildContext context , Widget page) {
return PageRouteBuilder(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) { 
      return page;    
    },
    transitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondAnimation, child){
      return FadeTransition(
        child: child,
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOut)
        ),
      );
    }
    );
}
