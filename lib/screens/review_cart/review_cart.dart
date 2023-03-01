import 'package:flutter/material.dart';
import 'package:food_delivery_app/config_color/colors.dart';
import 'package:food_delivery_app/model/review_cart_model.dart';
import 'package:food_delivery_app/providers/review_cart_provider.dart';
import 'package:food_delivery_app/screens/check_out/delivery_details/delivery_details.dart';
import 'package:provider/provider.dart';
import '../../widget/single_items.dart';


class ReviewCart extends StatefulWidget {
  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  late ReviewCartProvider reviewCartProvider;

  showAlertDialog(BuildContext context, ReviewCartModel delete) {
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
        reviewCartProvider.deleteReviewCartData(delete.cartID);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
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
    reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text('Total Amount'),
        subtitle: Text(
          '\$ ${reviewCartProvider.getTotalPrice()}',
          style: TextStyle(color: Colors.green[900]),
        ),
        trailing: Container(
          color: primaryColor,
          width: 160,
          child: MaterialButton(
            child: Text('Submit'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              if(reviewCartProvider.getreviewcartDataList.isEmpty){
                return null;
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryDetails()));
              }
            },
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Review Cart'),
      ),
      body: reviewCartProvider.getreviewcartDataList.isEmpty
          ? Center(
              child: Text('No Data'),
            )
          : ListView.builder(
              itemCount: reviewCartProvider.getreviewcartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider.getreviewcartDataList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    SignleItem(
                      isbool: true,
                      productPrice: data.cartPrice,
                      productName: data.cartName,
                      productImage: data.cartImage,
                      productID: data.cartID,
                      productQuantity: data.cartQuantity,
                      productUnit: data.cartUnit,
                      wishList: true,
                      onDelete: () {
                        showAlertDialog(context, data);
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}
