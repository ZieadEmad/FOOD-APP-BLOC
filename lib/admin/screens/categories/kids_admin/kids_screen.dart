import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/all_meals_cubit/cubit.dart';
import 'package:food_project/admin/all_meals_cubit/states.dart';
import 'package:food_project/admin/home_screen.dart';
import 'package:food_project/admin/screens/edit_meal/edit_meal_screen.dart';
import 'package:food_project/screens/categories/kids/cubit/cubit.dart';
import 'package:food_project/screens/categories/kids/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';


class KidsAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appetizers'),
        actions: [
          SizedBox(width: 10,),
          InkWell(
            onTap: (){navigateAndFinish(context, AdminHomeScreen());},
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home,color: Colors.white,),
                  Text('HOME'),
                ],
              ),
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      drawer: buildAdminDrawer(context),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AllMealsCubit(),
          ),
        ],
        child: BlocProvider(
          create: (context) => KidsMealsCubit()..kidsMeal(),
          child: BlocConsumer<KidsMealsCubit, KidsMealsStates>(
            listener: (context, state) {
              if (state is KidsMealsStateLoading) {
                print('ChickenSandwichStateLoading');
                return buildProgress(context: context, text: "please Wait.. ");
              }
              if (state is KidsMealsStateSuccess) {
                print('ChickenSandwichStateSuccess');
              }
              if (state is KidsMealsStateError) {
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
              List kidsMeals = KidsMealsCubit.get(context).kidsMeals;
              List kidsMealsId = KidsMealsCubit.get(context).kidsMealsId;
              return ConditionalBuilder(
                  condition: state is KidsMealsStateLoading   ,
                  builder: (context) => Center(child: CircularProgressIndicator(),),
                  fallback:(context)=> BlocConsumer<AllMealsCubit,AllMealsStates>(
                    listener: (context,state){},
                    builder: (context,state){
                      return  Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                itemBuilder: (context, index) =>
                                    buildMealItems(
                                        imageUrl: kidsMeals[index]['imageLink'].toString(),
                                        price: kidsMeals[index]['MealPrice'].toString(),
                                        title: kidsMeals[index]['MealTitle'].toString(),
                                        dec: kidsMeals[index]['MealDescription'].toString(),
                                        buttonTitle: 'Delete Meal',
                                        buttonColor:Colors.red,
                                        buttonFunction: () {
                                          if (kidsMealsId != null) {
                                            AllMealsCubit.get(context).deleteMeal(
                                              documentId: kidsMealsId,
                                              index: index,
                                            );
                                            navigateTo(context,KidsAdminScreen());
                                          }
                                        },
                                        isAdmin: true,
                                        buttonColor2: Colors.green,
                                        buttonTitle2: 'Edit Meal',
                                        buttonFunction2: (){navigateAndFinish(context, EditMealScreen(index: index,
                                          meals: kidsMeals,
                                          mealsId: kidsMealsId,
                                        ),);}
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 25.0,
                                ),
                                itemCount: kidsMeals.length,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ]);
                    },
                  )
              );
            },
          ),
        ),
      ),
    );
  }
}