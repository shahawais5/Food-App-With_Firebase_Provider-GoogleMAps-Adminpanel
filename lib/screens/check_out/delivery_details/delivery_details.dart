import 'package:flutter/material.dart';
import 'package:food_delivery_app/config_color/colors.dart';
import 'package:food_delivery_app/model/address_model.dart';
import 'package:food_delivery_app/providers/check_out_provider.dart';
import 'package:food_delivery_app/screens/check_out/add_delivery_address/add_delivery_address.dart';
import 'package:food_delivery_app/screens/check_out/delivery_details/single_delivery.dart';
import 'package:food_delivery_app/screens/check_out/payment_summary/payment_summary.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  late DeliveryAddressModel value;
  // bool isAddress = false;



  @override
  Widget build(BuildContext context) {
    CheckOutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddress();
    return Scaffold(
      appBar: AppBar(
        title: Text('Deliver Details'),
        backgroundColor: primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PaymentSummary(
              )));
        },
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: 150,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Text('Add new Address')
              : Text('Payment Summary'),
          onPressed: () {
            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddDeliveryAddress()))
                : Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentSummary(
                    )));
          },
          color: primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Deliver To'),
            leading: Image.network(
              'https://w7.pngwing.com/pngs/137/787/png-transparent-location-icon-computer-icons-map-location-map-geolocation-symbol-svg-thumbnail.png',
              height: 30,
            ),
          ),
          Divider(height: 1, color: primaryColor),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Container(
              child: Center(child: Text('No Data')
              )
          ):
          Column(children:
            deliveryAddressProvider.getDeliveryAddressList.map<Widget>((e){
              setState(() {
                value=e;
              });
              return SingleDeliveryItem(
                address:
                "Area, ${e.Area}, Street, ${e.Street}, Society ${e.Society}, PinCode ${e.PinCode}",
                title: "${e.firstName} ${e.lastName}",
                number: e.mobNo,
                addressType: e == "AddressType.Home"
                    ? "Home"
                    : e.AddresType == "AddressType.Others"
                    ? "Others"
                    : "Work",
              );
            }).toList()
          )
        ],
      ),
    );
  }
}
