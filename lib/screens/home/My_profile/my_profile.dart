import 'package:flutter/material.dart';
import 'package:food_delivery_app/config_color/colors.dart';
import 'package:food_delivery_app/providers/user_provider.dart';
import 'package:food_delivery_app/screens/home/drawer_side.dart';


class MyProfile extends StatefulWidget {
  UserProvider userProvider;
  MyProfile({required this.userProvider});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Widget listTile(IconData icon, String title) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(
          'My Profile',
          style: TextStyle(fontSize: 18, color: textColor),
        ),
      ),
      drawer: DrawerScreen(userProvider:widget.userProvider,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                color: primaryColor,
              ),
              Container(
                height: 548,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    color: scafoldbackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 80,
                          width: 250,
                          padding: EdgeInsets.only(left: 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData.userName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(userData.userEmail,style: TextStyle(fontSize: 12),),
                                ],
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: primaryColor,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: scafoldbackgroundColor,
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    listTile(Icons.shop, 'My Orders'),
                    listTile(Icons.location_on_outlined, 'My Delivery Address'),
                    listTile(Icons.person_outline, 'Refer A Friends'),
                    listTile(Icons.file_copy_outlined, 'Term & Condition'),
                    listTile(Icons.policy_outlined, 'Privacy & Policy'),
                    listTile(Icons.add_chart, 'About'),
                    listTile(Icons.exit_to_app_outlined, 'logOut'),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  userData.userImage),
                radius: 45,
                backgroundColor: scafoldbackgroundColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
