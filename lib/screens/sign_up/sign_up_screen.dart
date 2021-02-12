import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/login/login_screen.dart';
import 'package:food_project/screens/sign_up/cubit/cubit.dart';
import 'package:food_project/screens/sign_up/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';

class SignUpScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit,SignUpStates>(
      listener: (context,state){
        if (state is SignUpStateLoading) {
          print('SignUpStateLoading');
          return buildProgress(
              context: context,
              text: "please Wait until creating an account.. "
          );
        }
        if (state is SignUpStateSuccess) {
          print('SignUpStateSuccess');
          return navigateAndFinish(
            context,
            LoginScreen(
              Email: emailController.text,
              Pass: passController.text,
              authResult:state.authRuslut,
            ),
          );
        }
        if (state is SignUpStateError) {
          print('SignUpStateError');
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
          appBar: AppBar(
            title: Text('SignUp'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Center(
                      child: Container(
                        child: logo(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  defaultTextBox(
                    title: "Email",
                    hint: 'Enter your Email',
                    controller: emailController,
                    type: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTextBox(
                    title: "Password",
                    hint: 'Enter your Password',
                    controller: passController,
                    type: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  defaultButton(
                    function: () {
                      String email= emailController.text ;
                      String password = passController.text;
                      if(email.isEmpty|| password.isEmpty)
                      {
                        showToast(text: 'please enter a valid data', error:  true );
                        return ;
                      }
                      //cunit
                      SignUpCubit.get(context).register(email: email,password: password);
                    },
                    text: 'signUp',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    function: () {
                      navigateTo(context, LoginScreen());
                    },
                    text: "Back To Login",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
