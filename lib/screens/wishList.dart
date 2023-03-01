import 'package:flutter/material.dart';
import 'package:food_delivery_app/config_color/colors.dart';
import 'package:food_delivery_app/model/product_model.dart';
import 'package:food_delivery_app/providers/wish_list_provider.dart';
import 'package:provider/provider.dart';
import '../../widget/single_items.dart';


class WishList extends StatefulWidget {

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  late WishListProvider wishListProvider;

  showAlertDialog(BuildContext context, ProductModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("NO"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("YES"),
      onPressed: () {
        wishListProvider.deleteWishList(delete.productID);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("WishList Product"),
      content: Text("Are you Sure you Want To Delete Product"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    wishListProvider=Provider.of(context);
    wishListProvider.getWishtListData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('WishList'),
      ),
      body: ListView.builder(
        itemCount: wishListProvider.getWishList.length,
        itemBuilder: (context, index) {
          ProductModel data =
          wishListProvider.getWishList[index];
          print(data);
          return Column(
            children: [
              SizedBox(
                height: 15,
              ),
              SignleItem(
                wishList: true,
                isbool: true,
                productPrice: data.productPrice,
                productName: data.productName,
                productImage: data.productImage,
                productID: data.productID,
                productQuantity: data.productPrice,
                productUnit: data.productUnit,
                onDelete: () {
                  showAlertDialog(context,data);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
