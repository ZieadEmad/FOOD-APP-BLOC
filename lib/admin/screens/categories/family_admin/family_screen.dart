import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/all_meals_cubit/cubit.dart';
import 'package:food_project/admin/all_meals_cubit/states.dart';
import 'package:food_project/admin/home_screen.dart';
import 'package:food_project/admin/screens/edit_meal/edit_meal_screen.dart';
import 'package:food_project/screens/categories/family/cubit/cubit.dart';
import 'package:food_project/screens/categories/family/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';

class FamilyAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Family Meals'),
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
          create: (context) => FamilyMealsCubit()..familyMeal(),
          child: BlocConsumer<FamilyMealsCubit, FamilyMealsStates>(
            listener: (context, state) {
              if (state is FamilyMealsStateLoading) {
                print('ChickenSandwichStateLoading');
                return buildProgress(context: context, text: "please Wait.. ");
              }
              if (state is FamilyMealsStateSuccess) {
                print('ChickenSandwichStateSuccess');
              }
              if (state is FamilyMealsStateError) {
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
              List familyMeals = FamilyMealsCubit.get(context).familyMeals;
              List familyMealsId = FamilyMealsCubit.get(context).familyMealsId;
              return ConditionalBuilder(
                  condition: state is FamilyMealsStateLoading   ,
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
                                        imageUrl: familyMeals[index]['imageLink'].toString(),
                                        price: familyMeals[index]['MealPrice'].toString(),
                                        title: familyMeals[index]['MealTitle'].toString(),
                                        dec: familyMeals[index]['MealDescription'].toString(),
                                        buttonTitle: 'Delete Meal',
                                        buttonColor:Colors.red,
                                        buttonFunction: () {
                                          if (familyMealsId != null) {
                                            AllMealsCubit.get(context).deleteMeal(
                                              documentId: familyMealsId,
                                              index: index,
                                            );
                                            navigateTo(context,FamilyAdminScreen());
                                          }
                                        },
                                        isAdmin: true,
                                        buttonColor2: Colors.green,
                                        buttonTitle2: 'Edit Meal',
                                        buttonFunction2: (){navigateAndFinish(context, EditMealScreen(index: index,
                                          meals: familyMeals,
                                          mealsId: familyMealsId,
                                        ),);}
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 25.0,
                                ),
                                itemCount: familyMeals.length,
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