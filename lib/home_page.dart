import 'package:flutter/material.dart';
import 'package:prueba_abalit/coocking_item_list_page.dart';
import 'package:prueba_abalit/delivery_list_page.dart';
import 'dataClasses/user.dart';

///La página principal de la app
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.user});

  final String title;
  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(top: 50, bottom: 10),
              alignment: Alignment.center,
              child: Text(widget.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25))),
          Expanded(
            flex: 2,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeliveryListPage(
                                user: widget.user,
                              )));
                },
                child: homeWidget(
                    "Gourmet delivery",
                    "Te llevamos a casa los mejores platos"
                        " gourmet de alta gastronomía cocinados"
                        "al vacío Sous-Vide a baja temperatura por nuestros chefs",
                    "assets/home.jpg")),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CoockingItemListPage(
                                user: widget.user,
                              )));
                },
                child: homeWidget(
                    "Equipos para cocinar",
                    "Para cocinar al vacío Sous-Vide a baja temperatura y robots "
                        "diseñados para hacer fácil y práctica la buena cocina",
                    "assets/home2.jpg")),
          ),
        ],
      ),
    );
  }

  ///Contiene cada uno de los dos apartados en la portada (para ahorrar código)
  Widget homeWidget(String tittle, String description, String assetsImg) {
    return Stack(children: [
      Image.asset(
        assetsImg,
        fit: BoxFit.fill,
        width: double.maxFinite,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              tittle,
              style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ]);
  }
}
