
import 'package:flutter/material.dart';

class MainBackground extends StatelessWidget {
  const MainBackground({
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 32),
    super.key
  });

  final Widget? child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          colors: [
            Color(0xff5BC8E2),
            Color(0xffF3F2F8)
          ]
        )
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 0.7,
          colors: [
            const Color(0xff2465DF),
            const Color(0xff91B2EF).withOpacity(0.9),
            Colors.white.withOpacity(0)
          ],
          stops: const [0, 0.5,1],          
          ),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      )
    );       
  }
}