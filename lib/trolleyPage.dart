import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prueba_abalit/lists/trolley_items_list.dart';
import 'dataClasses/item.dart';
import 'dataClasses/user.dart';

///Página con todos los elementos del carrito y el precio
class TrolleyPage extends StatefulWidget {
  const TrolleyPage({super.key, required this.user});

  final User user;

  @override
  State<TrolleyPage> createState() => _TrolleyPageState();
}

class _TrolleyPageState extends State<TrolleyPage> {
  int price = 0;
  int shippingCosts = 5;
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();

    for (Item i in widget.user.shoppingList) {
      price += i.price!;
    }

    totalPrice = price + shippingCosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Carrito",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: widget.user.shoppingList.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "No hay elementos en el carrito",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
              )
            : Column(
                children: [
                  TrolleyItemsList(user: widget.user),
                  prices("Precio", "$price€"),
                  prices("Gastos de envío", "$shippingCosts€"),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Text("Precio total",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                        Expanded(
                            flex: 1,
                            child: Text("$totalPrice€",
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(60),
                      width: 250,
                      child: const ElevatedButton(
                          onPressed: null, child: Text("Siguiente")))
                ],
              ));
  }

  ///Widget con la fila de precio para ahorrar código
  Widget prices(String text, String amount) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Expanded(
              flex: 1, child: Text(text, style: const TextStyle(fontSize: 20))),
          Expanded(
              flex: 1,
              child: Text(amount,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 20)))
        ],
      ),
    );
  }
}
