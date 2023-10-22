import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Clase para facilitar el uso de Ftoasts
class FToastItem extends StatelessWidget {
  const FToastItem({super.key, required this.msg, required this.color});

  final String msg;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: color,
              border: Border.all(),
              borderRadius: BorderRadius.circular(25)),
          child: Text(
            textAlign: TextAlign.center,
            msg,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          )),
    ]);
  }
}
