class Product {
  String name;
  double price;
  int quantitycart = 1;
  int quantityprod;
  List imagesUrl;
  String documentId;
  String suppId;
  Product({
    required this.name,
    required this.price,
    required this.quantitycart,
    required this.quantityprod,
    required this.imagesUrl,
    required this.documentId,
    required this.suppId,
  });
  void increase() {
    quantitycart++;
  }

  void decrease() {
    quantitycart--;
  }
}
