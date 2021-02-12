import 'package:flutter/material.dart';
import 'package:food_project/screens/login/login_screen.dart';
import 'package:food_project/screens/sign_up/sign_up_screen.dart';
import 'package:food_project/shared/colors/colors.dart';
import 'package:food_project/shared/componentes/components.dart';

class WelcomeScreen extends StatelessWidget {
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

              SizedBox(height: 120,),
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
                      onTap: (){}
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
                    onTap: (){},
                  ),

                ],
              )
            ]
        ),
      ),
    );
  }
}
