import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../model/product_model.dart';


class WishListProvider with ChangeNotifier {
  addWishListData({
    required String wishListID,
    required String wishListName,
    var wishListPrice,
    var wishListUnit,
    required String wishListImage,
    required int wishListQuantity,
  }) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(wishListID)
        .set({
      "wishListId": wishListID,
      "wishListName": wishListName,
      "wishListImage": wishListImage,
      "wishListPrice": wishListPrice,
      "wishListProductUnit":wishListUnit,
      "wishListQuantity": wishListQuantity,
      "wishList": true,
    });
  }

/////////////////////////////getWishtListData////////////////////////////////

  List<ProductModel> wishList = [];

  getWishtListData() async {
    List<ProductModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .get();
    value.docs.forEach(
      (element) {
        ProductModel productModel = ProductModel(
            productID: element.get("wishListId"),
            productImage: element.get("wishListImage"),
            productName: element.get("wishListName"),
            productPrice: element.get("wishListPrice"),
            productUnit: element.get('wishListProductUnit')
        );
        newList.add(productModel);
      },
    );
    wishList = newList;
    notifyListeners();
  }

  List<ProductModel> get getWishList {
    return wishList;
  }

  /////////////////////// DELETE ///////////////

  deleteWishList(wishListID) {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(wishListID)
        .delete();
  }
}
