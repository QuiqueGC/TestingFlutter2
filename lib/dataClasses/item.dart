///Clase para almacenar los datos extraídos del JSON
class Item {
  String? title;
  String? id;
  String? image;
  String? description;
  int? price;
  int? type;

  Item.fromJSON(Map<String, dynamic> parsedJSON) {
    title = parsedJSON["title"];
    id = parsedJSON["title"];
    image = parsedJSON["image"];
    description = parsedJSON["description"];
    price = parsedJSON["price"];
    type = parsedJSON["type"];
  }

  Item(
      this.title, this.id, this.image, this.description, this.price, this.type);
}
