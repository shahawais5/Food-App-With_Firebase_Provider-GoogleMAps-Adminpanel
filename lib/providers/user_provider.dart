import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/model/user_model.dart';

class UserProvider with ChangeNotifier {
  void addUserData({
    required User currentuser,
    required String userName,
    required String userEmail,
    required String userImage,
  }) async {
    await FirebaseFirestore.instance
        .collection('userData')
        .doc(currentuser.uid)
        .set({
      "userName": userName,
      "userEmail": userEmail,
      "userImage": userImage,
      "userUid": currentuser.uid,
    });
    notifyListeners();
  }


  late UserModel currentData;
  void getUserData() async {
    UserModel userModel;
    var value =await FirebaseFirestore.instance
        .collection('userData')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if(value.exists)
    {

    }
    userModel=UserModel(
        userImage: value.get('userImage'),
        userEmail: value.get('userEmail'),
        userName: value.get('userName'),
        userUid: value.get('userUid'),
    );
    currentData=userModel;
    notifyListeners();
  }
  UserModel get currentUserData{
    return currentData;
  }
}
