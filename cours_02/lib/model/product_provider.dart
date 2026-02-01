import 'package:flutter/widgets.dart';
import 'package:formation_flutter/model/product.dart';

class ProductProvider extends InheritedWidget {
  final Product product;

  const ProductProvider({
    super.key,
    required this.product,
    required super.child,
  });

  static ProductProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProductProvider>();
  }

  @override
  bool updateShouldNotify(ProductProvider oldWidget) => product != oldWidget.product;
}
