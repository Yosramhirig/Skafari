import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skafari/models/ktor/ProductResponse.dart';


class StoreapiProvider extends ChangeNotifier{

  Dio? dio;
  List<ProductResponse>? data;

  StoreapiProvider(){
    print("product provider constructor");
    dio = Dio(
        BaseOptions(
            contentType: "Application/json"
        )
    );
  }

  Future<List<ProductResponse>?> getProducts(String Storename) async {
    print("get products called");
    var response = await dio?.get("http://10.0.2.2:8080/$Storename");

    List<dynamic> jsonList = response?.data;
    data = jsonList.map((item) => ProductResponse.fromJson(item)).toList();
    //PostResponse.fromJson(response?.data);

    return data;

  }

  Future<bool> getproductbybarcode(String Storename, String barcode) async {
    print("get products called");
    var response = await dio?.get("http://10.0.2.2:8080/$Storename/$barcode");

    List<dynamic> jsonList = response?.data;
    data = jsonList.map((item) => ProductResponse.fromJson(item)).toList();
    //PostResponse.fromJson(response?.data);
    notifyListeners();

    return data!.isEmpty ? false : true;

  }

}