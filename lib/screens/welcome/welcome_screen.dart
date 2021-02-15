import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/login/login_screen.dart';
import 'package:food_project/screens/login_mobile_number/mobile_number_screen.dart';
import 'package:food_project/screens/sign_up/sign_up_screen.dart';
import 'package:food_project/shared/colors/colors.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:food_project/shared/network/local/local.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeScreen extends StatelessWidget {


  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes:
    [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Center(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: AssetImage('assets/images/news_logo.png'),
              //         fit: BoxFit.cover
              //       )
              //     ),
              //   ),
              // ),

              logo(),
              SizedBox(height: 50,),

              Text('Tasty APP',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: defaultColor
              ),),

              SizedBox(height: 80,),
              defaultButton(
                text: 'login',
                function: (){
                  navigateTo(context,LoginScreen());
                },
                toUpper: true ,

              ),

              SizedBox(height: 20,),
              defaultButton(
                text: 'SignUp',
                function: (){
                  navigateTo(context,SignUpScreen());
                },
                toUpper: true ,
              ),

              SizedBox(height: 60,),
              captionText('Or Login With'),

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: CircleAvatar(
                      backgroundColor: defaultColor,
                      radius: 20,
                      child: Image(
                        image: AssetImage('assets/images/facebook.png'),
                        height: 23,
                        width: 23,
                        color: Colors.white,
                      ),
                    ),
                    onTap: (){},
                  ),

                  SizedBox(width: 20,),
                  InkWell(
                      child: CircleAvatar(
                        backgroundColor: defaultColor,
                        radius: 20,
                        child: Image(
                          image: AssetImage('assets/images/google.png'),
                          height: 23,
                          width: 23,
                          color: Colors.white,
                        ),
                      ),
                      onTap: (){
                        handleSignIn(context);
                      }
                  ),

                  SizedBox(width: 20,),
                  InkWell(
                    child: CircleAvatar(
                      backgroundColor: defaultColor,
                      radius: 20,
                      child: Image(
                        image: AssetImage('assets/images/smartphone.png'),
                        height: 23,
                        width: 23,
                        color: Colors.white,
                      ),
                    ),
                   onTap: (){navigateTo(context, PhoneScreen());},
                  ),

                ],
              )
            ]
        ),
      ),
    );
  }
  Future<void> handleSignIn(ctx) async {
    await googleSignIn.signIn().then((value) async
    {
      print(value.email);
      print(value.displayName);
      print(value.photoUrl);


      GoogleSignInAuthentication googleSignInAuthentication = await value.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        print(value.user.uid);
        //print('token-------${googleSignInAuthentication.accessToken}');
        saveToken(googleSignInAuthentication.accessToken).then((value)
        {
          if(value){
            showToast(text:'success save token', error: false);
            navigateAndFinish(ctx ,LayoutScreen());
          }
          else{
            showToast(text:'Error while saving a token', error: true);
          }
        });
        // navigateAndFinish(ctx, HomeScreen(saveToken()));
      }).catchError((e)
      {
        print(e.toString());
      });

    }).catchError((e){
      print(e.toString());
    });
  }
}
