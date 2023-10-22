import 'item.dart';

///Clase para almacenar cada uno de los usuarios registrados
class User {
  String mail;
  String passwd;
  String name;
  int phone;
  List<Item> shoppingList = [];

  User(this.mail, this.passwd, this.name, this.phone);
}
