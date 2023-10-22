import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///La página del buscador
class BrowserPage extends StatelessWidget {
  const BrowserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const SizedBox(
            width: 300,
            height: 50,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: null,
              decoration: InputDecoration(
                  hintText: "¿Qué buscas?", border: OutlineInputBorder()),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(width: 5, color: Colors.grey))),
          child: Center(
            child: Image.asset("assets/back_buscador.png"),
          ),
        ));
  }
}
