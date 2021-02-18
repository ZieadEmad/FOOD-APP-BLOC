
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/login/cubit/cubit.dart';
import 'package:food_project/screens/login/cubit/states.dart';
import 'package:food_project/screens/login/login_screen.dart';
import 'package:food_project/shared/componentes/components.dart';

class ForgotPasswordScreen extends StatelessWidget {
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(title: Text('Forgot Your Password'),),
            body: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Container(
                        child: logo(),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),

                    defaultTextBox(
                      type: TextInputType.emailAddress,
                      title: 'Your Email',
                      hint: 'ziead@gmail.com',
                      controller: emailController ,
                    ),

                    SizedBox(
                      height: 80,
                    ),


                    SizedBox(
                      height: 10,
                    ),
                    defaultButton(
                      function: () {
                     String email = emailController.text;
                        if(email.isEmpty){
                          showToast(text: 'please enter a valid data', error: true);
                        }
                        else{
                          LoginCubit.get(context).recoveryPassword(email.toString());
                          showToast(text: 'Check Your Email', error: false);
                          navigateAndFinish(context, LoginScreen());
                        }
                      },
                      text: "recovery Password",
                    ),

                    SizedBox(height: 20,),


                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}
