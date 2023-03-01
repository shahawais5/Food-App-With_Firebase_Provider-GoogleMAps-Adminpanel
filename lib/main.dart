import 'package:flutter/material.dart';
import 'package:food_delivery_app/auth/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_delivery_app/providers/check_out_provider.dart';
import 'package:food_delivery_app/providers/product_provider.dart';
import 'package:food_delivery_app/providers/review_cart_provider.dart';
import 'package:food_delivery_app/providers/user_provider.dart';
import 'package:food_delivery_app/providers/wish_list_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<CheckOutProvider>(
          create: (context) => CheckOutProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
   ChangeNotifierProvider<WishListProvider>(
    create: (context) => WishListProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignIn(),
      ),
    );
  }
}
