import 'package:flutter/material.dart';
import 'model/product.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class ProductNotifier extends ChangeNotifier {
  Product? _product;
  String? _error;

  Product? get product => _product;
  String? get error => _error;

  ProductNotifier() {
    loadProductFromApi('5000159484695');
  }

  Future<void> loadProductFromApi(String barcode) async {
    _product = null;
    _error = null;
    notifyListeners();
    try {
      final dio = Dio();
      final response = await dio.get('https://api.formation-flutter.fr/v2/getProduct?barcode=$barcode');
      
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data is String ? json.decode(response.data) : response.data;
        ProductNetworkModel? networkModel;
        if (data['response'] != null) {
          networkModel = ProductNetworkModel.fromJSON(data['response']);
        }
        _product = networkModel?.toProduct();
        _error = data['error'] ?? (_product == null ? 'Produit non trouvé dans la réponse.' : null);
      } else {
        _error = 'Erreur HTTP: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Erreur lors de la requête: $e';
      _product = null;
    }
    notifyListeners();
  }

  Product _parseProduct(Map<String, dynamic> json) {
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

  ProductNutriScore _parseNutriScore(dynamic value) {
    switch (value) {
      case 'A': return ProductNutriScore.A;
      case 'B': return ProductNutriScore.B;
      case 'C': return ProductNutriScore.C;
      case 'D': return ProductNutriScore.D;
      case 'E': return ProductNutriScore.E;
      default: return ProductNutriScore.unknown;
    }
  }

  ProductNovaScore _parseNovaScore(dynamic value) {
    switch (value) {
      case 'group1': return ProductNovaScore.group1;
      case 'group2': return ProductNovaScore.group2;
      case 'group3': return ProductNovaScore.group3;
      case 'group4': return ProductNovaScore.group4;
      default: return ProductNovaScore.unknown;
    }
  }

  ProductGreenScore _parseGreenScore(dynamic value) {
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
