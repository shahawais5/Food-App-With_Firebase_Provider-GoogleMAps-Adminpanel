import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config_color/colors.dart';
import 'package:food_delivery_app/screens/review_cart/review_cart.dart';
import 'package:provider/provider.dart';

import '../../providers/wish_list_provider.dart';
import '../../widget/count.dart';

enum SigninCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productID;
  final int productPrice;
  ProductOverview(
      {required this.productName,
      required this.productID,
      required this.productImage,
      required this.productPrice});

  //const ProductOverview({Key? key}) : super(key: key);

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  late WishListProvider wishListProvider;

  SigninCharacter _character = SigninCharacter.fill;

  Widget botomNavigationBar({
    required Color iconColor,
    required Color backgroundColor,
    required Color color,
    required String title,
    required Function onTap,
    required IconData iconData,
  }) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 20,
              color: iconColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(color: color),
            )
          ],
        ),
      ),
    ));
  }

  bool wishlistBool = false;

  getWishListBool() {
    FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourWishList')
        .doc(widget.productID)
        .get()
        .then((value) => {
          if(this.mounted){
            if (value.exists)
              {
                setState(() {
                  wishlistBool = value.get('wishList');
                })
              }
          }

            });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    getWishListBool();
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          botomNavigationBar(
              iconColor: Colors.grey,
              backgroundColor: textColor,
              color: Colors.white70,
              title: 'Add To WishList',
              iconData: wishlistBool == false
                  ? Icons.favorite_outline
                  : Icons.favorite,
              onTap: () {
                  setState(() {
                    wishlistBool = !wishlistBool;
                  });
                if (wishlistBool == true) {
                  wishListProvider.addWishListData(
                    wishListID: widget.productID,
                    wishListPrice: widget.productPrice,
                    wishListName: widget.productName,
                    wishListImage: widget.productImage,
                    wishListQuantity: 2,
                  );
                } else
                   {wishListProvider.deleteWishList(widget.productID);}
              }),
          botomNavigationBar(
              iconColor: Colors.white70,
              backgroundColor: primaryColor,
              color: textColor,
              title: 'Go To Cart',
              iconData: Icons.shop_outlined,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewCart()));
              }),
        ],
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Product Overview',
          style: TextStyle(color: textColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(widget.productName),
                      subtitle: Text('\$${widget.productPrice}'),
                    ),
                    Container(
                        height: 250,
                        padding: const EdgeInsets.all(40),
                        child: Image.network(widget.productImage)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: Text(
                        'Available Option',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 3,
                                backgroundColor: Colors.green[700],
                              ),
                              Radio(
                                  activeColor: Colors.green[700],
                                  value: SigninCharacter.fill,
                                  groupValue: _character,
                                  onChanged: (value) {
                                      setState(() {
                                        _character = value!;
                                      });
                                  })
                            ],
                          ),
                          Text('\$${widget.productPrice}'),
                          Counter(
                            productImage: widget.productImage,
                            productName: widget.productName,
                            productPrice: widget.productPrice,
                            productID: widget.productID,
                            productUnit: '500 Gram',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About this product',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Everything You Need to Know available here we are providing a good high quality things that you need our services will impress you in future.',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
