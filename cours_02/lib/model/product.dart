class ProductNetworkModel {
  final String barcode;
  final String? name;
  final String? altName;
  final Map<String, dynamic>? pictures;
  final String? quantity;
  final List<String>? brands;
  final List<String>? manufacturingCountries;
  final dynamic nutriScore;
  final dynamic novaScore;
  final dynamic ecoScoreGrade;
  final Map<String, dynamic>? ingredients;
  final Map<String, dynamic>? traces;
  final Map<String, dynamic>? allergens;
  final Map<String, dynamic>? additives;
  final Map<String, dynamic>? analysis;

  ProductNetworkModel({
    required this.barcode,
    this.name,
    this.altName,
    this.pictures,
    this.quantity,
    this.brands,
    this.manufacturingCountries,
    this.nutriScore,
    this.novaScore,
    this.ecoScoreGrade,
    this.ingredients,
    this.traces,
    this.allergens,
    this.additives,
    this.analysis,
  });

  factory ProductNetworkModel.fromJSON(Map<String, dynamic> json) {
    return ProductNetworkModel(
      barcode: json['barcode'] ?? '',
      name: json['name'],
      altName: json['altName'],
      pictures: json['pictures'],
      quantity: json['quantity'],
      brands: (json['brands'] as List?)?.map((e) => e.toString()).toList(),
      manufacturingCountries: (json['manufacturingCountries'] as List?)?.map((e) => e.toString()).toList(),
      nutriScore: json['nutriScore'],
      novaScore: json['novaScore'],
      ecoScoreGrade: json['ecoScoreGrade'],
      ingredients: json['ingredients'],
      traces: json['traces'],
      allergens: json['allergens'],
      additives: json['additives'],
      analysis: json['analysis'],
    );
  }

  Product toProduct() {
    return Product(
      barcode: barcode,
      name: name,
      altName: altName,
      picture: (pictures?['product'] ?? pictures?['front']) as String?,
      quantity: quantity,
      brands: brands,
      manufacturingCountries: manufacturingCountries,
      nutriScore: Product._parseNutriScore(nutriScore),
      novaScore: Product._parseNovaScore(novaScore),
      greenScore: Product._parseGreenScore(ecoScoreGrade),
      ingredients: (ingredients?['list'] as List?)?.map((e) => e.toString()).toList(),
      ingredientsWithAllergens: ingredients?['withAllergens'],
      traces: (traces?['list'] as List?)?.map((e) => e.toString()).toList(),
      allergens: (allergens?['list'] as List?)?.map((e) => e.toString()).toList(),
      additives: (additives as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())),
      nutrientLevels: null,
      nutritionFacts: null,
      ingredientsFromPalmOil: ingredients?['containsPalmOil'],
      containsPalmOil: ProductAnalysis.fromString(analysis?['palmOil']),
      isVegan: ProductAnalysis.fromString(analysis?['vegan']),
      isVegetarian: ProductAnalysis.fromString(analysis?['vegetarian']),
    );
  }
}
// ignore_for_file: constant_identifier_names
class Product {
  final String barcode;
  final String? name;
  final String? altName;
  final String? picture;
  final String? quantity;
  final List<String>? brands;
  final List<String>? manufacturingCountries;
  final ProductNutriScore? nutriScore;
  final ProductNutriScoreLevels? nutriScoreLevels;
  final ProductNovaScore? novaScore;
  final ProductGreenScore? greenScore;
  final List<String>? ingredients;

  // Eg: "Sucre, <span class=\"allergen\">gluten de blé</span>"
  final String? ingredientsWithAllergens;
  final List<String>? traces;
  final List<String>? allergens;
  final Map<String, String>? additives;
  final NutrientLevels? nutrientLevels;
  final NutritionFacts? nutritionFacts;
  final bool? ingredientsFromPalmOil;
  final ProductAnalysis? containsPalmOil;
  final ProductAnalysis? isVegan;
  final ProductAnalysis? isVegetarian;

  Product({
    required this.barcode,
    this.name,
    this.altName,
    this.picture,
    this.quantity,
    this.brands,
    this.manufacturingCountries,
    this.nutriScore,
    this.nutriScoreLevels,
    this.novaScore,
    this.greenScore,
    this.ingredients,
    this.ingredientsWithAllergens,
    this.traces,
    this.allergens,
    this.additives,
    this.nutrientLevels,
    this.nutritionFacts,
    this.ingredientsFromPalmOil,
    this.containsPalmOil,
    this.isVegan,
    this.isVegetarian,
  });

  factory Product.fromJSON(Map<String, dynamic> json) {
    return Product(
      barcode: json['barcode'] ?? '',
      name: json['name'],
      altName: json['altName'],
      picture: (json['pictures']?['product'] ?? json['pictures']?['front']) as String?,
      quantity: json['quantity'],
      brands: (json['brands'] as List?)?.map((e) => e.toString()).toList(),
      manufacturingCountries: (json['manufacturingCountries'] as List?)?.map((e) => e.toString()).toList(),
      nutriScore: _parseNutriScore(json['nutriScore']),
      novaScore: _parseNovaScore(json['novaScore']),
      greenScore: _parseGreenScore(json['ecoScoreGrade']),
      ingredients: (json['ingredients']?['list'] as List?)?.map((e) => e.toString()).toList(),
      ingredientsWithAllergens: json['ingredients']?['withAllergens'],
      traces: (json['traces']?['list'] as List?)?.map((e) => e.toString()).toList(),
      allergens: (json['allergens']?['list'] as List?)?.map((e) => e.toString()).toList(),
      additives: (json['additives'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())),
      nutrientLevels: null, // À compléter si besoin
      nutritionFacts: null, // À compléter si besoin
      ingredientsFromPalmOil: json['ingredients']?['containsPalmOil'],
      containsPalmOil: ProductAnalysis.fromString(json['analysis']?['palmOil']),
      isVegan: ProductAnalysis.fromString(json['analysis']?['vegan']),
      isVegetarian: ProductAnalysis.fromString(json['analysis']?['vegetarian']),
    );
  }

  static ProductNutriScore _parseNutriScore(dynamic value) {
    switch (value) {
      case 'A': return ProductNutriScore.A;
      case 'B': return ProductNutriScore.B;
      case 'C': return ProductNutriScore.C;
      case 'D': return ProductNutriScore.D;
      case 'E': return ProductNutriScore.E;
      default: return ProductNutriScore.unknown;
    }
  }

  static ProductNovaScore _parseNovaScore(dynamic value) {
    switch (value) {
      case 'group1':
      case 1: return ProductNovaScore.group1;
      case 'group2':
      case 2: return ProductNovaScore.group2;
      case 'group3':
      case 3: return ProductNovaScore.group3;
      case 'group4':
      case 4: return ProductNovaScore.group4;
      default: return ProductNovaScore.unknown;
    }
  }

  static ProductGreenScore _parseGreenScore(dynamic value) {
    switch (value) {
      case 'A': return ProductGreenScore.A;
      case 'APlus': return ProductGreenScore.APlus;
      case 'B': return ProductGreenScore.B;
      case 'C': return ProductGreenScore.C;
      case 'D': return ProductGreenScore.D;
      case 'E': return ProductGreenScore.E;
      case 'F': return ProductGreenScore.F;
      default: return ProductGreenScore.unknown;
    }
  }
}

class ProductResponse {
  final Product? product;
  final String? error;

  ProductResponse({this.product, this.error});

  factory ProductResponse.fromJSON(Map<String, dynamic> json) {
    return ProductResponse(
      product: json['response'] != null ? Product.fromJSON(json['response']) : null,
      error: json['error'],
    );
  }
}

class NutritionFacts {
  final String servingSize;
  final Nutriment? calories;
  final Nutriment? fat;
  final Nutriment? saturatedFat;
  final Nutriment? carbohydrate;
  final Nutriment? sugar;
  final Nutriment? fiber;
  final Nutriment? proteins;
  final Nutriment? sodium;
  final Nutriment? salt;
  final Nutriment? energy;

  NutritionFacts({
    required this.servingSize,
    this.calories,
    this.fat,
    this.saturatedFat,
    this.carbohydrate,
    this.sugar,
    this.fiber,
    this.proteins,
    this.sodium,
    this.salt,
    this.energy,
  });
}

class Nutriment {
  final String unit;
  final dynamic perServing;
  final dynamic per100g;

  Nutriment({required this.unit, this.perServing, this.per100g});
}

class NutrientLevels {
  final String? salt;
  final String? saturatedFat;
  final String? sugars;
  final String? fat;

  NutrientLevels({this.salt, this.saturatedFat, this.sugars, this.fat});
}

class ProductNutriScoreLevels {
  final ProductNutriScoreLevel? energy;
  final ProductNutriScoreLevel? fiber;
  final ProductNutriScoreLevel? fruitsVegetablesLegumes;
  final ProductNutriScoreLevel? proteins;
  final ProductNutriScoreLevel? salt;
  final ProductNutriScoreLevel? saturatedFat;
  final ProductNutriScoreLevel? sugars;

  ProductNutriScoreLevels({
    required this.energy,
    required this.fiber,
    required this.fruitsVegetablesLegumes,
    required this.proteins,
    required this.salt,
    required this.saturatedFat,
    required this.sugars,
  });
}

class ProductNutriScoreLevel {
  final double points;
  final double maxPoints;
  final String unit;
  final double value;
  final ProductNutriScoreLevelType type;

  ProductNutriScoreLevel({
    required this.points,
    required this.maxPoints,
    required this.unit,
    required this.value,
    required this.type,
  });
}

enum ProductNutriScoreLevelType { positive, negative, unknown }

enum ProductNutriScore { A, B, C, D, E, unknown }

enum ProductNovaScore { group1, group2, group3, group4, unknown }

enum ProductGreenScore { A, APlus, B, C, D, E, F, unknown }

enum ProductAnalysis {
  yes,
  no,
  maybe;

  static ProductAnalysis fromString(String? analysis) {
    return switch (analysis) {
      'yes' => ProductAnalysis.yes,
      'no' => ProductAnalysis.no,
      'maybe' => ProductAnalysis.maybe,
      _ => ProductAnalysis.maybe,
    };
  }
}

Product generateProduct() => Product(
  barcode: '1234567890',
  name: 'Nutella',
  altName: 'Product Alt Name',
  picture:
      'https://images.openfoodfacts.org/images/products/301/762/042/5035/front_fr.533.400.jpg',
  quantity: '200g',
  brands: ['Ferrero', 'Ferrero'],
  manufacturingCountries: ['France', 'Italie'],
  nutriScore: ProductNutriScore.E,
  novaScore: ProductNovaScore.group4,
  greenScore: ProductGreenScore.D,
  ingredients: [
    'Sucre',
    'sirop de glucose',
    '_lait_ écrémé',
    'crème légère (_lait_)',
    'eau',
    'beurre de cacao',
    'matière grasse de noix de coco',
    '_lait_ écrémé concentré sucré',
    'pâte de cacao',
    'farine de _blé_',
    'matière grasse de palme',
    '_lait_ écrémé en poudre',
    '_lactose_',
    'matière grasse du _lait_',
    'huile de palmiste',
    'petit-_lait_ en poudre',
    'cacao maigre',
    'beurre (_lait_)',
    'émulsifiants (lécithine de _soja_, E471, tristéarate de sorbitane)',
    '_lait_ entier en poudre',
    'stabilisants (E407, E410, E412)',
    'arômes naturels (_lait_)',
    'sel',
    'colorant naturel (caramel ordinaire)',
    'cacao en poudre',
    'poudre à lever (E503)',
    'extrait naturel de vanille',
  ],
  ingredientsWithAllergens:
      'Sucre, sirop de glucose, <span class=\"allergen\">lait</span> écrémé, crème légère (<span class=\"allergen\">lait</span>), eau, beurre de cacao, matière grasse de noix de coco, <span class=\"allergen\">lait</span> écrémé concentré sucré, pâte de cacao, farine de <span class=\"allergen\">blé</span>, matière grasse de palme, <span class=\"allergen\">lait</span> écrémé en poudre, <span class=\"allergen\">lactose</span>, matière grasse du <span class=\"allergen\">lait</span>, huile de palmiste, petit-<span class=\"allergen\">lait</span> en poudre, cacao maigre, <span class=\"allergen\">beurre</span> (<span class=\"allergen\">lait</span>), émulsifiants (lécithine de <span class=\"allergen\">soja</span>, E471, tristéarate de sorbitane), <span class=\"allergen\">lait</span> entier en poudre, stabilisants (E407, E410, E412), arômes naturels (<span class=\"allergen\">lait</span>), sel, colorant naturel (caramel ordinaire), cacao en poudre, poudre à lever (E503), extrait naturel de vanille. (Peut contenir<span class=\"allergen\">: cacahuète</span>, <span class=\"allergen\">noisette</span>, <span class=\"allergen\">amande</span>).',
  traces: ['cacahuète', 'noisette', 'amande'],
  allergens: ['lait', 'soja', 'beurre'],
  additives: {'e322i': 'Description', 'e471': 'Description'},
  nutriScoreLevels: ProductNutriScoreLevels(
    energy: ProductNutriScoreLevel(
      points: 3,
      maxPoints: 10,
      unit: 'kJ',
      value: 1180,
      type: ProductNutriScoreLevelType.negative,
    ),
    saturatedFat: ProductNutriScoreLevel(
      points: 9,
      maxPoints: 10,
      unit: 'g',
      value: 9.05,
      type: ProductNutriScoreLevelType.negative,
    ),
    sugars: ProductNutriScoreLevel(
      points: 7,
      maxPoints: 15,
      unit: 'g',
      value: 25.5,
      type: ProductNutriScoreLevelType.negative,
    ),
    proteins: ProductNutriScoreLevel(
      points: 1,
      maxPoints: 7,
      unit: 'g',
      value: 3.5,
      type: ProductNutriScoreLevelType.positive,
    ),
    fiber: ProductNutriScoreLevel(
      points: 0,
      maxPoints: 5,
      unit: 'g',
      value: 0,
      type: ProductNutriScoreLevelType.unknown,
    ),
    salt: ProductNutriScoreLevel(
      points: 1,
      maxPoints: 20,
      unit: 'g',
      value: 0,
      type: ProductNutriScoreLevelType.positive,
    ),
    fruitsVegetablesLegumes: ProductNutriScoreLevel(
      points: 0,
      maxPoints: 5,
      unit: '%',
      value: 0,
      type: ProductNutriScoreLevelType.positive,
    ),
  ),
  nutrientLevels: NutrientLevels(
    salt: 'Low',
    saturatedFat: 'Low',
    sugars: 'Low',
    fat: 'Low',
  ),
  nutritionFacts: NutritionFacts(
    servingSize: '100g',
    calories: Nutriment(unit: 'kcal', perServing: 100, per100g: 100),
    fat: Nutriment(unit: 'g', perServing: 10, per100g: 10),
    saturatedFat: Nutriment(unit: 'g', perServing: 5, per100g: 5),
    carbohydrate: Nutriment(unit: 'g', perServing: 20, per100g: 20),
    sugar: Nutriment(unit: 'g', perServing: 10, per100g: 10),
    fiber: Nutriment(unit: 'g', perServing: 5, per100g: 5),
    proteins: Nutriment(unit: 'g', perServing: 10, per100g: 10),
    sodium: Nutriment(unit: 'mg', perServing: 100, per100g: 100),
    salt: Nutriment(unit: 'g', perServing: 0.1, per100g: 0.1),
  ),
);
