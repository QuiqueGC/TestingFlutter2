import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../dataClasses/item.dart';
import '../dataClasses/user.dart';
import '../item_detail_page.dart';

///Clase que contiene el layout de la lista en
///la que están los elementos en venta
class ItemsList extends StatelessWidget {
  const ItemsList({super.key, required this.itemsList, required this.user});

  final List<Item> itemsList;
  final User user;

  ///La lista que devolveremos
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemBuilder: itemOfList,
          itemCount: itemsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
        ),
      ),
    );
  }

  ///Cada uno de los elementos
  Widget? itemOfList(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDetailPage(
                      item: itemsList[index],
                      title: "Delivery",
                      user: user,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                itemsList[index].image!,
                height: 80,
                fit: BoxFit.fill,
                width: double.maxFinite,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "${itemsList[index].price!}€",
                style: const TextStyle(
                    fontSize: 20, color: CupertinoColors.activeGreen),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              itemsList[index].title!,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
