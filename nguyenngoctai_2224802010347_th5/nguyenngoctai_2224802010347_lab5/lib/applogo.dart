import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CommonLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.network(
          "https://th.bing.com/th/id/OIP.RHvaQQV43Q-XYHnR3aSJVAHaFj?w=225&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3",
          width: 100,
        ),
        "To-Do App".text.xl2.italic.make(),
        "Make A List of your task".text.light.white.wider.lg.make(),
      ],
    );
  }
}
