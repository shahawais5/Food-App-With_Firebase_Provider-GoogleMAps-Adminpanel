import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/model/address_model.dart';
import 'package:location/location.dart';

class CheckOutProvider with ChangeNotifier{

  bool isLoading=false;

  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  TextEditingController mobNo=TextEditingController();
  TextEditingController AlternativeMobNo=TextEditingController();
  TextEditingController Society=TextEditingController();
  TextEditingController Street=TextEditingController();
  TextEditingController landMArk=TextEditingController();
  TextEditingController City=TextEditingController();
  TextEditingController Area=TextEditingController();
  TextEditingController PinCode=TextEditingController();
  late Location setLocation;


  void validator(context,  _myType)async{
    if(firstName.text.isEmpty){
      Fluttertoast.showToast(msg: 'First Name Is Empty');
    }else if(lastName.text.isEmpty){
      Fluttertoast.showToast(msg: 'Last Name is Empty');
    }else if(mobNo.text.isEmpty){
      Fluttertoast.showToast(msg: 'mobile number is Empty');
    }else if(AlternativeMobNo.text.isEmpty){
      Fluttertoast.showToast(msg: 'Alter mob no is Empty');
    }else if(Society.text.isEmpty){
      Fluttertoast.showToast(msg: 'Society is Empty');
    }else if(Street.text.isEmpty){
      Fluttertoast.showToast(msg: 'Street is Empty');
    }else if(landMArk.text.isEmpty){
      Fluttertoast.showToast(msg: 'LanMArk is Empty');
    }else if(City.text.isEmpty){
      Fluttertoast.showToast(msg: 'City is Empty');
    }else if(Area.text.isEmpty){
      Fluttertoast.showToast(msg: 'Area is Empty');
    }else if(PinCode.text.isEmpty){
      Fluttertoast.showToast(msg: 'PinCode is Empty');
    }else{
      isLoading=true;
      notifyListeners();
      await FirebaseFirestore.instance.collection('AddDeliveryAddress').doc(FirebaseAuth.instance.currentUser!.uid).set(
          {
            'firstName': firstName.text,
            'lastName': lastName.text,
            'mobNo': mobNo.text,
            'AlternativeMobNo': AlternativeMobNo.text,
            'Society': Society.text,
            'Street': Street.text,
            'landMArk': landMArk.text,
            'City': City.text,
            'Area': Area.text,
            'PinCode': PinCode.text,
            'AddressType': _myType.toString(),

          }).then((value) async {
            isLoading=false;
            notifyListeners();
            await Fluttertoast.showToast(msg: 'Add Your Delivery Address');
            Navigator.of(context as BuildContext).pop();
            notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAddressList=[];

   getDeliveryAddress()async{
     List<DeliveryAddressModel>newlist=[];
    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db=await FirebaseFirestore.instance.collection('AddDeliveryAddress').
    doc(FirebaseAuth.instance.currentUser!.uid).get();
    if(_db.exists){
       deliveryAddressModel=DeliveryAddressModel(
           Area: _db.get('Area'),
           AlternativeMobNo: _db.get('AlternativeMobNo'),
           City: _db.get('City'),
           firstName: _db.get('firstName'),
           landMArk: _db.get('landMArk'),
           lastName: _db.get('lastName'),
           mobNo: _db.get('mobNo'),
           PinCode: _db.get('PinCode'),
           Street: _db.get('Street'),
           Society: _db.get('Society'),
           AddresType:_db.get('AddressType')
       );
       newlist.add(deliveryAddressModel);
       notifyListeners();
    }
     newlist=deliveryAddressList;
     notifyListeners();
  }
  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAddressList;
  }

}