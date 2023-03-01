import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  late ProductModel productModel;



  ///////////Function for same data///////////
  List<ProductModel> search = [];


  productsModel(QueryDocumentSnapshot element) {
    productModel = ProductModel(
        productName: element.get("productImage"),
        productID: element.get("productID"),
        productImage: element.get("productName"),
        productPrice: element.get("productPrice"),
      productUnit: element.get('productUnit'),
    );
    return search.add(productModel);
  }




//////////////// Herbs Product //////////////////////////////////////
  List<ProductModel> herbsProductList = [];

  fetchHerbsProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("HerbsProduct").get();
    value.docs.forEach((element) {
      // print(element.data());
      productsModel(element);
      newList.add(productModel);
    });
    herbsProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getHerbsProductDataList {
    return herbsProductList;
  }




//////////////// Fresh Product //////////////////////////////////////

  List<ProductModel> freshProductList = [];

  fatchFreshProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("FreshFruits").get();

    value.docs.forEach((element) {
      // print(element.data());
      productsModel(element);
      newList.add(productModel);
    });
    freshProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getFreshProductDataList {
    return freshProductList;
  }





//////////////// Root Product //////////////////////////////////////

  List<ProductModel> rootProductList = [];

  fatchRootProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("RootProducts").get();

    value.docs.forEach((element) {
      // print(element.data());
      productsModel(element);
      newList.add(productModel);
    });
    rootProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getrootProductDataList {
    return rootProductList;
  }

  /////////search all product data///////////
  List<ProductModel> get getallproductsearchdata {
    return search;
}}
