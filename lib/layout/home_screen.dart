import 'package:flutter/material.dart';
import 'package:food_project/screens/welcome/welcome_screen.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:food_project/shared/network/local/local.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME PAGE'),
      ),
      body: Center(child: InkWell(
          onTap: (){
        removeToken();
        navigateAndFinish(context, WelcomeScreen());
      },
        child: Text('HOME SCREEN'),
      ),
      ),
    );
  }
}
