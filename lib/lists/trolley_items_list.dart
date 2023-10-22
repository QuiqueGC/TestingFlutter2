import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../dataClasses/item.dart';
import '../dataClasses/user.dart';
import '../trolleyPage.dart';

///Clase que define el layout de la lista de objetos del carrito
class TrolleyItemsList extends StatefulWidget {
  const TrolleyItemsList({super.key, required this.user});

  final User user;

  @override
  State<TrolleyItemsList> createState() => _TrolleyItemsListState();
}

class _TrolleyItemsListState extends State<TrolleyItemsList> {
  ///La lista que devolveremos
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(
                top: (BorderSide(width: 5, color: Colors.grey)),
                bottom: BorderSide(color: Colors.grey))),
        width: double.maxFinite,
        height: 400,
        child: ListView.builder(
          itemBuilder: itemInTrolley,
          itemCount: widget.user.shoppingList.length,
        ));
  }

  ///Cada uno de los elementos de la lista
  Widget? itemInTrolley(BuildContext context, int index) {
    Item itemInShopList = widget.user.shoppingList[index];

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Image.network(
            itemInShopList.image!,
            fit: BoxFit.fill,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    itemInShopList.title!,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("${itemInShopList.price}€",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Expanded(
                          flex: 1, child: Icon(Icons.remove_circle_outline)),
                      const Expanded(
                          flex: 1,
                          child: Text(
                            "1",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                      const Expanded(
                          flex: 1, child: Icon(Icons.add_circle_outline_sharp)),
                      Expanded(
                          flex: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.user.shoppingList.removeAt(index);
                              });

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TrolleyPage(
                                            user: widget.user,
                                          )));
                            },
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: const Icon(Icons.delete)),
                          ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
