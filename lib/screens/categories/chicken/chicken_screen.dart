import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/cart/cubit/cubit.dart';
import 'package:food_project/screens/cart/cubit/states.dart';
import 'package:food_project/screens/categories/chicken/cubit/cubit.dart';
import 'package:food_project/screens/categories/chicken/cubit/state.dart';
import 'package:food_project/screens/favorites/cubit/cubit.dart';
import 'package:food_project/screens/favorites/cubit/states.dart';
import 'package:food_project/screens/favorites/favorites_screen.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class ChickenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chicken Sandwichs'),
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
                      OMIcons.home,
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
          create: (context) => ChickenSandwichCubit()..chickenSandwich(),
          child: BlocConsumer<ChickenSandwichCubit, ChickenSandwichStates>(
            listener: (context, state) {
              if (state is ChickenSandwichStateLoading) {
                print('ChickenSandwichStateLoading');
                return buildProgress(context: context, text: "please Wait.. ");
              }
              if (state is ChickenSandwichStateSuccess) {
                print('ChickenSandwichStateSuccess');
              }
              if (state is ChickenSandwichStateError) {
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
              List chickenMeals =
                  ChickenSandwichCubit.get(context).chickenMeals;
              List chickenMealsId =
                  ChickenSandwichCubit.get(context).chickenMealsId;
              return ConditionalBuilder(
                condition: state is ChickenSandwichStateLoading,
                builder: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
                fallback: (context) =>
                    BlocConsumer<FavoritesCubit, FavoritesStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return BlocConsumer<CartCubit, CartStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Column(
                            children: [
                          Expanded(
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                              itemBuilder: (context, index) => buildMealItems(
                                imageUrl:
                                    chickenMeals[index]['imageLink'].toString(),
                                price:
                                    chickenMeals[index]['MealPrice'].toString(),
                                title:
                                    chickenMeals[index]['MealTitle'].toString(),
                                dec: chickenMeals[index]['MealDescription']
                                    .toString(),
                                buttonFunction: () {
                                  CartCubit.get(context)
                                      .addCart(chickenMealsId[index]);
                                },
                                isRemove: false,
                                favoritesOnPress: () {
                                  FavoritesCubit.get(context)
                                      .addFavorites(chickenMealsId[index]);
                                },
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 25.0,
                              ),
                              itemCount: chickenMeals.length,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
