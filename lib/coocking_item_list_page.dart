import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_abalit/browser_page.dart';
import 'package:prueba_abalit/dataClasses/item.dart';
import 'package:prueba_abalit/lists/items_list.dart';
import 'package:prueba_abalit/trolleyPage.dart';
import 'dataClasses/user.dart';

///La página donde están los productos de cocina
class CoockingItemListPage extends StatefulWidget {
  const CoockingItemListPage({super.key, required this.user});

  final User user;

  @override
  State<CoockingItemListPage> createState() => _CoockingItemListPageState();
}

class _CoockingItemListPageState extends State<CoockingItemListPage> {
  final dio = Dio();
  bool loading = false;
  List<Item> itemsList = [];
  final int coockingItemType = 1;

  @override
  void initState() {
    super.initState();

    getHttp();
  }

  ///Función que extrae el JSON del enlace y lo pasa a la lista de Items
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

  ///Escoge los Items pertinentes en base al Type de los que hay en la lista
  List<Item> listDependingOnType() {
    return itemsList
        .where((element) => element.type == coockingItemType)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(flex: 6, child: Text("Productos")),
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
                      filterIcon("Ollas", "assets/cook.svg"),
                      filterIcon("Sartenes", "assets/pan.svg"),
                      filterIcon("Termos", "assets/thermo.svg"),
                      filterIcon("Arroceras", "assets/rice-cooker.svg"),
                    ],
                  ),
                ),
                ItemsList(
                  itemsList: listDependingOnType(),
                  user: widget.user,
                ),
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

  ///Widget que contiene cada uno de los iconos que aplican filtros
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
