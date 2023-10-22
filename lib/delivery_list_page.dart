import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_abalit/dataClasses/item.dart';
import 'package:prueba_abalit/lists/items_list.dart';
import 'package:prueba_abalit/trolleyPage.dart';

import 'browser_page.dart';
import 'dataClasses/user.dart';

///Página con los elementos de comida
class DeliveryListPage extends StatefulWidget {
  const DeliveryListPage({super.key, required this.user});

  final User user;

  @override
  State<DeliveryListPage> createState() => _DeliveryListPageState();
}

class _DeliveryListPageState extends State<DeliveryListPage> {
  final dio = Dio();
  bool loading = false;
  List<Item> itemsList = [];
  final int deliveryType = 2;

  @override
  void initState() {
    super.initState();

    getHttp();
  }

  ///Extrae el JSON del enlace y lo pasa a la lista
  ///(quizás este método debería estar en el home y no
  ///repetirse)
  Future<void> getHttp() async {
    setState(() {
      loading = true;
    });

    final response = await dio.get(
        "https://testback.apiabalit.com/getProducts.php",
        options: Options(responseType: ResponseType.plain));

    String dioResult = response.data.toString();

    Map<String, dynamic> data = (jsonDecode(dioResult));

    for (Map<String, dynamic> JSONElement in data["products"]) {
      //hago este bucle para que haya más elementos
      for (int i = 0; i <= 3; i++) {
        itemsList.add(Item.fromJSON(JSONElement));
      }
    }

    setState(() {
      loading = false;
    });
  }

  ///Extrae los elementos de la lista de Items con el type que nos interesa
  List<Item> listDependingOnType() {
    return itemsList.where((element) => element.type == deliveryType).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(flex: 6, child: Text("Delivery")),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BrowserPage()));
                  },
                  child: Image.asset(
                    "assets/lens.png",
                    height: 25,
                  ),
                )),
            const Expanded(flex: 1, child: Icon(Icons.access_time_outlined))
          ],
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 5, color: Colors.grey))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      filterIcon("Pasta", "assets/spaghetti.svg"),
                      filterIcon("Carne", "assets/steak.svg"),
                      filterIcon("Pescado", "assets/fish.svg"),
                      filterIcon("Verduras", "assets/carrot.svg"),
                      filterIcon("Fruta", "assets/apple.svg"),
                    ],
                  ),
                ),
                ItemsList(itemsList: listDependingOnType(), user: widget.user),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(15))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/profile.png",
                            width: 40,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TrolleyPage(
                                          user: widget.user,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/trolley.png",
                              width: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  ///El widget de cada uno de los iconos que aplican filtros
  Widget filterIcon(String name, String assetsSvg) {
    return Column(
      children: [
        SvgPicture.asset(
          assetsSvg,
          width: 20,
        ),
        Text(name)
      ],
    );
  }
} //
