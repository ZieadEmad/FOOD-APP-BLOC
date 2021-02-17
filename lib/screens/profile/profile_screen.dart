import 'package:flutter/material.dart';
import 'package:food_project/screens/orders/orders_screen.dart';
import 'package:food_project/shared/componentes/components.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: InkWell(
        onTap: (){navigateTo(context, UserOrdersScreen());},
        child: Text('go to orders'),),),
    );
  }
}
