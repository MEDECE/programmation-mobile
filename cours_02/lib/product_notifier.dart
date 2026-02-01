import 'package:flutter/material.dart';
import 'model/product.dart';

class ProductNotifier extends ChangeNotifier {
  Product? _product;

  Product? get product => _product;

  ProductNotifier() {
    loadProduct();
  }

  void loadProduct() {
    _product = generateProduct();
    notifyListeners();
  }
}
