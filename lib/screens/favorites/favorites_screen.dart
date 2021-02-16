import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/cart/cubit/cubit.dart';
import 'package:food_project/screens/cart/cubit/states.dart';
import 'package:food_project/screens/favorites/cubit/cubit.dart';
import 'package:food_project/screens/favorites/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return MultiBlocProvider(
     providers: [
       BlocProvider(
         create: (context) => CartCubit(),
       ),
     ],
     child: BlocProvider(
       create: (context)=> FavoritesCubit()..showFavorites(),
       child: BlocConsumer<FavoritesCubit,FavoritesStates>(
         listener: (context,state){
           if (state is ShowFavoritesStateLoading) {
             print('ShowFavoritesStateLoading');
             return buildProgress(
                 context: context,
                 text: "please Wait until creating an account.. "
             );
           }
           if (state is ShowFavoritesStateSuccess) {
             print('ShowFavoritesStateSuccess');
           }
           if (state is ShowFavoritesStateError) {
             print('ShowFavoritesStateError');
             Navigator.pop(context);
             return buildProgress(
               context: context,
               text: "${state.error.toString()}",
               error: true ,
             );
           }
         },
         builder: (context,state){
           List favoritesMeals =FavoritesCubit.get(context).favoritesMeals;
           List favoritesId =FavoritesCubit.get(context).favoritesId;
           return  ConditionalBuilder(
             condition: state is ShowFavoritesStateLoading ,
             builder: (context)=> Center(child: CircularProgressIndicator()) ,
            fallback: (context)=> BlocConsumer<CartCubit,CartStates>(
               listener: (context,state){},
               builder: (context,state){
                 return Scaffold(
                   body: Column(
                       children: [
                         SizedBox(height: 20,),
                         Expanded(
                           child: ListView.separated(
                             physics: BouncingScrollPhysics(),
                             padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                             itemBuilder: (context, index) =>
                                 buildMealItems(
                                   imageUrl: favoritesMeals[index]['imageLink'].toString(),
                                   price: favoritesMeals[index]['MealPrice'].toString(),
                                   title: favoritesMeals[index]['MealTitle'].toString(),
                                   dec: favoritesMeals[index]['MealDescription'].toString(),
                                   buttonFunction: (){
                                     CartCubit.get(context).addCart(favoritesMeals[index]['MealId']);
                                     navigateAndFinish(context, LayoutScreen());
                                     },
                                   isRemove: true,
                                   favoritesOnPress: (){
                                     FavoritesCubit.get(context).deleteMeal(documentId:favoritesId ,index: index);
                                     navigateAndFinish(context, LayoutScreen());
                                   },
                                 ),
                             separatorBuilder: (context, index) => SizedBox(
                               height: 25.0,
                             ),
                             itemCount: favoritesMeals.length,
                           ),
                         ),
                         SizedBox(
                           height: 20.0,
                         ),
                       ]),
                 ) ;
               },
           ),
           );
         },
       ),
     ),
   ) ;
  }
}
