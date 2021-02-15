


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/cubit/states.dart';
import 'file:///G:/Flutter_Pro/food_project/lib/screens/home/home_screen.dart';
import 'package:food_project/screens/Settings/Settings_screen.dart';
import 'package:food_project/screens/cart/cart_screen.dart';
import 'package:food_project/screens/profile/profile_screen.dart';

class LayoutCubit extends Cubit<LayoutStates> {

  LayoutCubit() : super(LayoutStateInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  var widget = [
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  var title = [
    'Tasty Restaurant',
    'Your Cart',
    'Your Profile',
    'Settings'
  ];

  int currentIndex = 0 ;

  changeIndex(index){
    currentIndex = index ;
    emit(LayoutStateIndex());
  }

}