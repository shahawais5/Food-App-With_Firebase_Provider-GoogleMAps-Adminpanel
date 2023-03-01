import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/review_cart_provider.dart';

class Counter extends StatefulWidget {
  String productID;
  String productName;
  String productImage;
  var productUnit;
  int productPrice;

  Counter({
    required this.productName,
    required this.productImage,
    required this.productUnit,
    required this.productPrice,
    // required this.productQuantity,
    required this.productID,
  });

  // const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  var count = 1;
  bool isTrue = false;

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourReviewCart")
        .doc(widget.productID)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(() {
                        count = value.get('cartQuantity');
                        isTrue = value.get('isAdd');
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuantity();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
        height: 30,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: isTrue == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (count == 1) {
                        setState(() {
                          isTrue = false;
                        });
                        reviewCartProvider
                            .deleteReviewCartData(widget.productID);
                      } else if (count > 1) {
                        setState(() {
                          count--;
                        });
                        reviewCartProvider.updateReviewCart(
                          cartID: widget.productID,
                          cartImage: widget.productImage,
                          cartName: widget.productName,
                          cartPrice: widget.productPrice,
                          cartQuantity: count.toInt(),
                        );
                      }
                    },
                    child: Icon(Icons.remove, size: 15, color: Colors.red),
                  ),
                  Text(
                    '${count.toInt()}',
                    style: TextStyle(color: Colors.green),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          count++;
                        });
                        reviewCartProvider.updateReviewCart(
                          cartID: widget.productID,
                          cartImage: widget.productImage,
                          cartName: widget.productName,
                          cartPrice: widget.productPrice,
                          cartQuantity: count.toInt(),
                        );
                      },
                      child: Icon(Icons.add, size: 15, color: Colors.blue)),
                ],
              )
            : Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isTrue = true;
                    });
                    reviewCartProvider.addReviewCart(
                        cartID: widget.productID,
                        cartImage: widget.productImage,
                        cartName: widget.productName,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                        cartUnit: widget.productUnit
                    );
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ));
  }
}
