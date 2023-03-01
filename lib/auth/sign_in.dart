import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../providers/user_provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import '../screens/home/home_screen.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late UserProvider userProvider;

   Future<User?> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );

      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      //print("signed in " + user.displayName);
      userProvider.addUserData(
          currentuser: user! ,
          userName: user.displayName as String,
          userEmail: user.email as String,
          userImage: user.photoURL as String
      );


      return user;
    } catch (msg) {
      print(msg.toString());
    }
   }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/background.png'),
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Sign in to continue'),
                  const Text(
                    'Vegi',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.green,
                              offset: Offset(4, 4))
                        ]),
                  ),
                  Column(
                    children: [
                      SignInButton(
                        Buttons.Apple,
                        text: "Sign In with Apple",
                        onPressed: () {},
                      ),
                      SignInButton(
                        Buttons.Google,
                        text: "Sign In with Google",
                        onPressed: () async {
                          await _googleSignUp().then((value) =>
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen())));
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Sign In if You Are agreeing with our',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                      Text('Terms Privacy And Policy',
                          style: TextStyle(color: Colors.grey.shade800))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
//
// class UserProvider {
//  late UserProvider provider;
// }
