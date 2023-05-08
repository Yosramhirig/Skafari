import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:openfoodfacts/model/ProductResultV3.dart';
import 'package:openfoodfacts/model/parameter/SearchTerms.dart';
import 'package:openfoodfacts/openfoodfacts.dart';



Future<Product?> getProduct(String barcode) async {
  final ProductQueryConfiguration configuration = ProductQueryConfiguration(
    barcode,
    language: OpenFoodFactsLanguage.ARABIC,
    fields: [ProductField.ALL],
    version: ProductQueryVersion.v3,
  );
  final ProductResultV3 result =
  await OpenFoodAPIClient.getProductV3(configuration);

  if (result.status == ProductResultV3.statusSuccess) {
    print(result.product);

    return result.product;
  } else {
    result.product = null;
    return result.product;
  }
}

Future<String> SearchProductByName(String term) async {
  ProductSearchQueryConfiguration configuration =
  ProductSearchQueryConfiguration(
    parametersList: <Parameter>[
      SearchTerms(terms: [term])
    ],
  );

  final SearchResult result = await OpenFoodAPIClient.searchProducts(
    User(userId: '', password: ''),
    configuration,
  );
  if (result.products?.isNotEmpty ?? false){
    return result.products?[0].barcode ?? "Null";
  }else{
    return "Null";
  }



}

class ProductsProvider extends ChangeNotifier{

  Dio? dio;
  Product? data;
  List<Product?> names = [];

  ProductsProvider(){
    print("products provider constructor");
    dio = Dio(
        BaseOptions(
            contentType: "Application/json"
        )
    );
  }


  Future<Product?> getProduct(String barcode) async {
    final ProductQueryConfiguration configuration = ProductQueryConfiguration(
      barcode,
      language: OpenFoodFactsLanguage.ARABIC,
      fields: [ProductField.ALL],
      version: ProductQueryVersion.v3,
    );
    final ProductResultV3 result =
    await OpenFoodAPIClient.getProductV3(configuration);

    if (result.status == ProductResultV3.statusSuccess) {
      data = result.product;
      notifyListeners();
      return result.product;

    } else {
      result.product = null;
      data = result.product;
      notifyListeners();
      return result.product;
    }
  }
  Future<List<Product?>> getProducts(List<String> barcodes) async {
    List<Product?> results = [];
    print("result input: $barcodes");
    print("result: $results");
    barcodes.forEach((element) async {
      print("loop $element");
      final ProductQueryConfiguration configuration = ProductQueryConfiguration(
        element,
        language: OpenFoodFactsLanguage.ARABIC,
        fields: [ProductField.ALL],
        version: ProductQueryVersion.v3,
      );
      final ProductResultV3 result =
          await OpenFoodAPIClient.getProductV3(configuration);
      print("104");
      if (result.status == ProductResultV3.statusSuccess) {
        data = result.product;
        notifyListeners();
        results.add(result.product);
        print("109");
      } else {
        result.product = null;
        data = result.product;
        notifyListeners();
        results.add(result.product);
        print("115");
      }
    });
    print("result: $results");
    names = results;
    notifyListeners();
    return results;

  }

}




