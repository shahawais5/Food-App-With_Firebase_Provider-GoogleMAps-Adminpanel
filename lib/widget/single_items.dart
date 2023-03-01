import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/config_color/colors.dart';
import 'package:food_delivery_app/providers/review_cart_provider.dart';
import 'package:food_delivery_app/widget/count.dart';
import 'package:provider/provider.dart';


class SignleItem extends StatefulWidget {
  String productImage;
  String productName;
  String productID;
  int productPrice;
  int productQuantity;
  Function onDelete;
  var productUnit;
  bool isbool = false;
  bool wishList=false;
  SignleItem(
      {Key? key,
      required this.isbool,
        required this.wishList,
        required this.productUnit,
      required this.onDelete,
      required this.productPrice,
      required this.productID,
      required this.productImage,
      required this.productName,
      required this.productQuantity})
      : super(key: key);

  @override
  State<SignleItem> createState() => _SignleItemState();
}

class _SignleItemState extends State<SignleItem> {
  late ReviewCartProvider reviewCartProvider;

  late int count;
  getCount(){
    setState(() {
      count=widget.productQuantity;
    });
  }



  @override
  Widget build(BuildContext context) {
    getCount();
    reviewCartProvider=Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 100,
                child: Center(
                  child: Image.network(widget.productImage),
                ),
              )),
              Expanded(
                  child: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: widget.isbool == false
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.productName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${widget.productPrice}/50Gram',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    widget.isbool == false
                        ? GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (context){
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    title: Text('50 Gram'),
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: Text('500 Gram'),
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: Text('1 Kg'),
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            }
                        );
                      },
                          child: Container(
                              margin: EdgeInsets.only(right: 15),
                              padding: EdgeInsets.symmetric(horizontal: 11),
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.grey)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '50 gram',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Center(
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 20,
                                      color: primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                        )
                        : Text(widget.productUnit),
                  ],
                ),
              )),
              Expanded(
                  child: Container(
                height: 100,
                child: Container(
                  padding: widget.isbool == false
                      ? EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                      : EdgeInsets.only(left: 15, right: 15),
                  height: 100,
                  child: widget.isbool == false
                      ? Counter(
                      productName: widget.productName,
                      productImage: widget.productImage,
                      productPrice: widget.productPrice,
                      productID: widget.productID,
                    productUnit: '500 Gram',
                  )
                      : Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.onDelete();
                                  });
                                },
                                child: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              widget.wishList==false
                              ?Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            if(count==1){
                                              Fluttertoast.showToast(msg: 'You reach minimum Limit');
                                            }else{
                                              setState(() {
                                                count --;
                                              });
                                              reviewCartProvider.updateReviewCart(
                                                  cartID: widget.productID,
                                                  cartName: widget.productName,
                                                  cartImage: widget.productImage,
                                                  cartPrice: widget.productPrice,
                                                  cartQuantity: count
                                              );
                                            }
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            size: 20,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          '$count',
                                          style: TextStyle(
                                              fontSize: 14, color: primaryColor),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            if(count < 10){
                                              Fluttertoast.showToast(msg: 'Are You Sure You Want to Add Product 10 Times');
                                              setState(() {
                                                count ++;
                                              });
                                              reviewCartProvider.updateReviewCart(
                                                  cartID: widget.productID,
                                                  cartName: widget.productName,
                                                  cartImage: widget.productImage,
                                                  cartPrice: widget.productPrice,
                                                  cartQuantity: count
                                              );
                                            }
                                          },
                                          child: Icon(
                                            Icons.add,
                                            size: 20,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )):Counter(
                                productImage: widget.productImage,
                                productName: widget.productName,
                                productPrice: widget.productPrice,
                                productID: widget.productID,
                                productUnit: '500 Gram',
                              ),
                            ],
                          ),
                      ),
                ),
              )),
            ],
          ),
          widget.isbool == false
              ? Container()
              : Divider(
                  height: 1,
                  color: Colors.black,
                )
        ],
      ),
    );
  }
}
