import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/shared/componentes/components.dart';



class PhoneScreen extends StatefulWidget {
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  var phoneController = TextEditingController();
  var codeController = TextEditingController();
  bool isCode = false ;
  String verCode ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone SignUp'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          children: [

            SizedBox(
              height: 20,
            ),
            logo(),

            if(!isCode)
              SizedBox(
                height: 60,
              ),
            if(!isCode)
              defaultTextBox(
                title: "Phone Number",
                hint: 'Enter Your Number',
                controller: phoneController,
                type: TextInputType.phone,
              ),

            if(isCode)
              SizedBox(
                height: 100,
              ),
            if(isCode)
              defaultTextBox(
                title: "Code",
                hint: 'Enter Your Verification Code',
                controller: codeController,
                type: TextInputType.number,
              ),


            SizedBox(
              height: 50,
            ),
            defaultButton(
              width: 200,
              toUpper: true,
              function: () {
                if (isCode)
                {
                  phoneAuthentication(codeController.text);
                  navigateAndFinish(context, LayoutScreen());
                }
                else
                {
                  String phone = phoneController.text;
                  if (phone.isEmpty) {
                    showToast(
                        text: 'please enter a valid Phone number', error: true);
                    return;
                  }
                  sendCode(phone);
                }
              },
              text: isCode? "Start" :"Next",
            ),
          ],
        ),
      ),
    );
  }

  void sendCode(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$number',
      verificationCompleted: (PhoneAuthCredential credential)
      {

      },
      verificationFailed: (FirebaseAuthException e)
      {
        print(e.message);
      },
      codeSent: (String verificationId , int resendToken)
      {
        isCode = true;
        verCode = verificationId ;
        setState(() {});
      } ,
      codeAutoRetrievalTimeout: (String verificationId)
      {
      },
    );
  }

  void phoneAuthentication(String code) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: this.verCode, smsCode: code);

    await FirebaseAuth.instance
        .signInWithCredential(phoneAuthCredential)
        .then((value) {
      print(value.user.uid);
    }).catchError((e)
    {
      print(e.toString());
    });
  }

}
