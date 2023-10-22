import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prueba_abalit/dataClasses/item.dart';
import 'package:prueba_abalit/trolleyPage.dart';
import 'dataClasses/user.dart';

///Página de detalle del elemento seleccionado
class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage(
      {super.key, required this.item, required this.title, required this.user});

  final Item item;
  final String title;
  final User user;

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Image.network(
                  widget.item.image!,
                  height: 250,
                  width: double.maxFinite,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.item.title!,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.item.price}€",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Descripción",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.item.description!),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 150),
                child: ElevatedButton(
                    onPressed: addingItemToTrolley,
                    child: const Text("Añadir al carrito")),
              )
            ],
          ),
        ));
  }

  ///Añade el elemento a la lista de la compra
  ///y redirige a la página del carrito
  void addingItemToTrolley() {
    widget.user.shoppingList.add(widget.item);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TrolleyPage(
                  user: widget.user,
                )));
  }
}
