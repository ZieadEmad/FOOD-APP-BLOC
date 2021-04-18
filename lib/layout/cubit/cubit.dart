

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/cubit/states.dart';
import 'package:food_project/screens/cart/cart_screen.dart';
import 'package:food_project/screens/favorites/favorites_screen.dart';
import 'package:food_project/screens/home/home_screen.dart';
import 'package:food_project/screens/profile/profile_screen.dart';
import 'package:food_project/screens/table/reserve_screen.dart';

class LayoutCubit extends Cubit<LayoutStates> {

  LayoutCubit() : super(LayoutStateInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  var widget = [
    HomeScreen(),
    FavoritesScreen() ,
    ProfileScreen(),
    ReserveScreen(),
  ];

  var title = [
    'Tasty Restaurant',
    'Favorites',
    'Your Profile',
    'Table Reserve',
  ];

  int currentIndex = 0 ;

  changeIndex(index){
    currentIndex = index ;
    emit(LayoutStateIndex());
  }

}