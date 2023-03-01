import 'package:flutter/material.dart';
import 'package:food_delivery_app/config_color/colors.dart';

class SingleDeliveryItem extends StatelessWidget {
  final String title;
  final String number;
  final String address;
  final String addressType;
  SingleDeliveryItem({
    required this.title,
    required this.number,
    required this.address,
    required this.addressType
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Container(
                width: 60,
                height: 20,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(addressType,style: TextStyle(fontSize: 13,color: Colors.white),),
                ),
              )
            ],
          ),
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage('https://logos.textgiraffe.com/logos/logo-name/Shah-designstyle-love-heart-m.png'),
            backgroundColor: primaryColor,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address),
              SizedBox(height: 5,),
              Text(number),
            ],
          ),
        ),
        Divider(
          height: 35,
        )
      ],
    );
  }
}
