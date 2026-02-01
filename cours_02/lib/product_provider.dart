import 'package:flutter/widgets.dart';
import 'package:formation_flutter/model/product.dart';

class ProductProvider extends InheritedWidget {
  final Product product;

  const ProductProvider({
    required this.product,
    required super.child,
    super.key,
  });

  static Product of(BuildContext context) {
    final ProductProvider? provider = context.dependOnInheritedWidgetOfExactType<ProductProvider>();
    assert(provider != null, 'Aucun ProductProvider trouvé dans le contexte');
    return provider!.product;
  }

  @override
  bool updateShouldNotify(ProductProvider oldWidget) => product != oldWidget.product;
}
