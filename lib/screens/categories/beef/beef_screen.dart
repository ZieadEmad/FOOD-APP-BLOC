import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/cart/cubit/cubit.dart';
import 'package:food_project/screens/categories/beef/cubit/cubit.dart';
import 'package:food_project/screens/categories/beef/cubit/states.dart';
import 'package:food_project/screens/favorites/cubit/cubit.dart';
import 'package:food_project/screens/favorites/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';

class BeefScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beef Sandwichs'),
        actions: [
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              navigateAndFinish(context, LayoutScreen());
            },
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  Text('HOME'),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FavoritesCubit(),
          ),
          BlocProvider(
            create: (context) => CartCubit(),
          ),
        ],
        child: BlocProvider(
          create: (context) => BeefSCubit()..beefMeal(),
          child: BlocConsumer<BeefSCubit, BeefStates>(
            listener: (context, state) {
              if (state is BeefStateLoading) {
                print('ChickenSandwichStateLoading');
                return buildProgress(context: context, text: "please Wait.. ");
              }
              if (state is BeefStateSuccess) {
                print('ChickenSandwichStateSuccess');
              }
              if (state is BeefStateError) {
                print('ChickenSandwichStateError');
                Navigator.pop(context);
                return buildProgress(
                  context: context,
                  text: "${state.error.toString()}",
                  error: true,
                );
              }
            },
            builder: (context, state) {
              List beefMeals = BeefSCubit.get(context).beefMeals;
              List beefMealsId = BeefSCubit.get(context).beefMealsId;
              return ConditionalBuilder(
                condition: state is BeefStateLoading   ,
                builder: (context) => Center(child: CircularProgressIndicator(),),
                fallback:(context) =>BlocConsumer<FavoritesCubit,FavoritesStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                              itemBuilder: (context, index) =>
                                  buildMealItems(
                                    imageUrl: beefMeals[index]['imageLink'].toString(),
                                    price: beefMeals[index]['MealPrice'].toString(),
                                    title: beefMeals[index]['MealTitle'].toString(),
                                    dec: beefMeals[index]['MealDescription'].toString(),
                                    buttonFunction: () {
                                      CartCubit.get(context)
                                          .addCart(beefMealsId[index]);
                                    },
                                    isRemove: false,
                                    favoritesOnPress: () {
                                      FavoritesCubit.get(context)
                                          .addFavorites(beefMealsId[index]);
                                    },
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 25.0,
                              ),
                              itemCount: beefMeals.length,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ]);
                  }

                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
