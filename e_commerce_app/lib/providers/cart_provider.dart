import 'package:flutter/foundation.dart';

import '../model/product.dart';

class Cart extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getItems {
    return _list;
  }

  int? get count {
    return _list.length;
  }

  double get totalPrice {
    var total = 0.0;

    for (var item in _list) {
      total += item.price * item.quantitycart;
    }
    return total;
  }

  void addItems(
    String name,
    double price,
    int quantitycart,
    int quantityprod,
    List imagesUrl,
    String documentId,
    String suppId,
  ) {
    final product = Product(
        name: name,
        price: price,
        quantitycart: quantitycart,
        quantityprod: quantityprod,
        imagesUrl: imagesUrl,
        documentId: documentId,
        suppId: suppId);
    _list.add(product);
    notifyListeners();
  }

  void increment(Product product) {
    product.increase();
    notifyListeners();
  }

  void reduce(Product product) {
    product.decrease();
    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }
}
