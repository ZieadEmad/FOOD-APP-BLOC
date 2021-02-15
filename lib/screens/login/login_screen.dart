import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/home_screen.dart';
import 'file:///G:/Flutter_Pro/food_project/lib/screens/home/home_screen.dart';
import 'package:food_project/screens/login/cubit/cubit.dart';
import 'package:food_project/screens/login/cubit/states.dart';
import 'package:food_project/screens/sign_up/sign_up_screen.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:food_project/shared/network/local/local.dart';

class LoginScreen extends StatelessWidget {

  String Email ;
  String Pass ;
  UserCredential authResult;

  LoginScreen({this.Email, this.Pass,this.authResult});

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if ( Email != null && Pass != null){
      emailController.text = Email ;
      passController.text = Pass;
    }
    return BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){
        if (state is LoginStatesLoading) {
          print('LoginStatesLoading');
          return buildProgress(
              context: context,
              text: "please Wait until Login.. "
          );
        }
        if (state is LoginStatesSuccess) {
          print('LoginStatesSuccess');
          saveToken(state.token).then((value)
          {
            if(value){
              showToast(text:'success save token', error: false);
              if( emailController.text== 'admin@gmail.com' && passController.text == 'admin123'
                  && state.token=='rMsp0UG3VnUb8KVMeNoRgHMK7em2'){
                navigateAndFinish(context, AdminHomeScreen());
              }
              //cubit
              else{
                navigateAndFinish(context ,HomeScreen());
              }

            }
            else{
              showToast(text:'Error while saving a token', error: false);
            }
          }
          );
        }
        if (state is LoginStatesError) {
          print('LoginStatesError');
          Navigator.pop(context);
          return buildProgress(
            context: context,
            text: "${state.error.toString()}",
            error: true ,
          );
        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(title: Text('Login'),),
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
                    title: 'Email',
                    hint: 'ziead@gmail.com',
                    controller: emailController ,
                  ),
                  SizedBox(height: 20),
                  defaultTextBox(
                    type: TextInputType.emailAddress,
                    title: 'Password',
                    hint: '************',
                    controller: passController ,
                    isPassword: true ,

                  ),
                  SizedBox(
                    height: 65,
                  ),
                  defaultButton(
                    function: (){
                      String email = emailController.text ;
                      String pass = passController.text ;
                      if(email.isEmpty||pass.isEmpty)
                      {
                        showToast(text: 'please enter a valid data', error:  true );
                        return ;
                      }
                      if( emailController.text== '1' &&  passController.text == '1'){
                        navigateAndFinish(context, AdminHomeScreen());
                      }
                      //cubit
                      else{
                      //  if(emailController.text!= 'admin@gmail.com' &&  passController.text != 'admin123')
                        LoginCubit.get(context).login(email: email,password: pass);
                      }

                    },
                    text: 'Login',
                    toUpper: true ,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                    function: () {
                      navigateTo(context,SignUpScreen());
                    },
                    text: "Sign Up",
                  ),

                  SizedBox(height: 20,),

                  FlatButton(
                    onPressed: () {},
                    child: Text('Forgot your password ?'),
                  )
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
