import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../model/review_cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  void addReviewCart(
      {
        required String cartID,
      required String cartName,
      required String cartImage,
      required int cartPrice,
      required int cartQuantity,
      required var cartUnit
      })async {
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourReviewCart")
        .doc(cartID)
        .set({
      "cartID": cartID,
      "cartName": cartName,
      "cartImage": cartImage,
      "cartPrice": cartPrice,
      "cartQuantity": cartQuantity,
      "cartUnit": cartUnit,
      "isAdd": true,
    });
  }

  ////////Update Cart////////////////

  void updateReviewCart({
    required String cartID,
    required String cartName,
    required String cartImage,
    required int cartPrice,
    required int cartQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourReviewCart")
        .doc(cartID)
        .update({
      "cartID": cartID,
      "cartName": cartName,
      "cartImage": cartImage,
      "cartPrice": cartPrice,
      "cartQuantity": cartQuantity,
      "isAdd": true,
    });
  }

  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];
    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourReviewCart')
        .get();
     reviewCartValue.docs.forEach((element) {
       ReviewCartModel reviewCartModel = ReviewCartModel(
           cartID: element.get('cartID'),
           cartImage: element.get('cartImage'),
           cartName: element.get('cartName'),
           cartPrice: element.get('cartPrice'),
           cartUnit: element.get('cartUnit'),
           cartQuantity: element.get('cartQuantity'));
       newList.add(reviewCartModel);
     });

    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getreviewcartDataList {
    return reviewCartDataList;
  }

  //////////total price///////////////



  getTotalPrice(){
    double total=0.0;
    reviewCartDataList.forEach((element) {
      total+=element.cartPrice*element.cartQuantity;
    });
    return total;
  }




  /////////////delete cart ////////////////////


  deleteReviewCartData(cartID) {
    FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourReviewCart')
        .doc(cartID)
        .delete();
    notifyListeners();
  }
}
