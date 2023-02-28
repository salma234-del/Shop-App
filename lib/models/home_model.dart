import 'package:flutter/cupertino.dart';

class HomeModel {
  bool status;
  HomeDataModel data;
  HomeModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = HomeDataModel.fromJson(json['data']);
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    banners = List.from(json['banners']).map((e)=> BannerModel.fromJson(e)).toList();
    products = List.from(json['products']).map((e)=> ProductModel.fromJson(e)).toList();
  }
}

class BannerModel {
  int id;
  String image;
  BannerModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'];
}

class ProductModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavorites;
  bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        oldPrice = json['old_price'],
        discount = json['discount'],
        image = json['image'],
        name = json['name'],
        inFavorites = json['in_favorites'],
        inCart = json['in_cart'];
}
