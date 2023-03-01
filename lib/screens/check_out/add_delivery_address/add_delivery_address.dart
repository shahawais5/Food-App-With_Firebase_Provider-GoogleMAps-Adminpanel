import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/check_out_provider.dart';
import 'package:food_delivery_app/screens/check_out/google_map/google_map.dart';
import 'package:provider/provider.dart';
import '../../../config_color/colors.dart';
import '../../../widget/custom_textfield.dart';

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({Key? key}) : super(key: key);


  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

enum AddressType{
  Home,
  Work,
  Others,
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  var _myType=AddressType.Home;
  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider=Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Add Delivery Address'),backgroundColor: primaryColor,),
      bottomNavigationBar: Container(
        height: 50,
        width: 150,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child:checkOutProvider.isLoading==false? MaterialButton(
          child: Text('Add Address'),
          onPressed: () {
            checkOutProvider.validator(context,_myType);
          },
          color: primaryColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ):Center(
          child: CircularProgressIndicator(),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CustemTxtField(
              labtext: 'First Name',
              keyboardType: TextInputType.text,
              controller: checkOutProvider.firstName,
            ),
            CustemTxtField(
              labtext: 'Last Name',
              controller: checkOutProvider.lastName,
              keyboardType: TextInputType.text,
            ),
            CustemTxtField(
              labtext: 'Mobile Number',
              controller: checkOutProvider.mobNo,
              keyboardType: TextInputType.text,
            ),
            CustemTxtField(
              controller: checkOutProvider.AlternativeMobNo,
              labtext: 'Alternative Mobile Number',
              keyboardType: TextInputType.text,
            ),
            CustemTxtField(
              labtext: 'Society ',
              controller: checkOutProvider.Society,
              keyboardType: TextInputType.text,
            ),
            CustemTxtField(
              controller: checkOutProvider.Street,
              labtext: 'Street',
              keyboardType: TextInputType.text,
            ),
            CustemTxtField(
              controller: checkOutProvider.landMArk,
              labtext: 'LandMArk',
              keyboardType: TextInputType.text,
            ),
            CustemTxtField(
              controller: checkOutProvider.City,
              labtext: 'City ',
              keyboardType: TextInputType.text,
            ),
            CustemTxtField(
              labtext: 'Area',
              controller: checkOutProvider.Area,
              keyboardType: TextInputType.text,
            ),
            CustemTxtField(
              controller: checkOutProvider.PinCode,
              labtext: 'PinCode',
              keyboardType: TextInputType.text,
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomGoogleMap()));
              },
              child: Container(
                height: 55,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('set Loaction')
                  ],
                ),
              )
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text('Address Type'),
            ),
            RadioListTile(
                value: AddressType.Home,
                title: Text('Home'),
                groupValue:_myType,
                secondary: Icon(Icons.home,color: primaryColor,),
                onChanged: (value){
                  setState(() {
                    _myType=value!;
                  });
                }
            ),
            RadioListTile(
                value: AddressType.Work,
                title: Text('Work'),
                groupValue: _myType,
                secondary: Icon(Icons.work,color: primaryColor,),
                onChanged: (onChanged){
                  setState(() {
                    _myType=onChanged!;
                  });
                }
            ),
            RadioListTile(
                value: AddressType.Others,
                groupValue: _myType,
                title: Text('Others'),
                secondary: Icon(Icons.devices_other,color: primaryColor,),
                onChanged: (values){
                  setState(() {
                    _myType=values!;
                  });
                }
            ),
          ],
        ),
      ),
    );
  }
}
