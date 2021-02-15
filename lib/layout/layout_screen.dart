import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/cubit/cubit.dart';
import 'package:food_project/layout/cubit/states.dart';
import 'package:food_project/shared/colors/colors.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var currentIndex = LayoutCubit.get(context).currentIndex;
        return Scaffold(
          appBar: AppBar(
           title: Text(LayoutCubit.get(context).title[currentIndex]),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 10,
                  blurRadius: 15,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                topLeft: Radius.circular(25.0),
              ),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(OMIcons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(OMIcons.shoppingCart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(OMIcons.person),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(OMIcons.settings),
                  label: 'Settings',
                ),
              ],
              onTap: (index) {
                LayoutCubit.get(context).changeIndex(index);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: defaultColor,
              currentIndex: currentIndex,
            ),
          ),
          body: LayoutCubit.get(context).widget[currentIndex],
        );
      },
    );
  }
}
