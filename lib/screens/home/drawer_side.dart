import 'package:flutter/material.dart';
import 'package:food_delivery_app/config_color/colors.dart';
import 'package:food_delivery_app/providers/user_provider.dart';
import 'package:food_delivery_app/screens/home/My_profile/my_profile.dart';
import 'package:food_delivery_app/screens/home/home_screen.dart';
import 'package:food_delivery_app/screens/review_cart/review_cart.dart';
import '../wishList.dart';

class DrawerScreen extends StatefulWidget {
  UserProvider userProvider;
  DrawerScreen({required this.userProvider});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Widget Listtile(
    IconData icon,
    String title,
  ) {
    return ListTile(
      // onTap: onTap(),
      leading: Icon(
        icon,
        size: 32,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black45),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;
    return Drawer(
        child: Container(
      color: primaryColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 39,
                    backgroundImage: NetworkImage(userData.userImage),
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(userData.userName),
                    Text(
                      userData.userEmail,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Listtile(Icons.home_outlined, 'Home')),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReviewCart()));
              },
              child: Listtile(Icons.shop_outlined, 'Review Cart')),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyProfile(
                              userProvider: widget.userProvider,
                            )));
              },
              child: Listtile(Icons.person, 'My Profile')),
          Listtile(Icons.notification_important, 'Notification'),
          Listtile(Icons.star_outline, 'Reviews & Rating'),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WishList()));
              },
              child: Listtile(Icons.favorite_outline, 'WishList')),
          Listtile(Icons.copy_outlined, 'Raise a Complaint'),
          Listtile(Icons.format_quote_sharp, 'FAQs'),
          Container(
            height: 230,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 162),
                  child: Text(
                    'Contact Support',
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          'Call Us:',
                          style: TextStyle(color: Colors.black45),
                        ),
                        Text(
                          '+923135264072',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          'Mail Us:',
                          style: TextStyle(color: textColor),
                        ),
                        Text('Shahbusiness@gmail.com',
                            style: TextStyle(color: textColor)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
