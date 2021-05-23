import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/all_meals_cubit/cubit.dart';
import 'package:food_project/admin/all_meals_cubit/states.dart';
import 'package:food_project/admin/home_screen.dart';
import 'package:food_project/admin/screens/edit_meal/edit_meal_screen.dart';
import 'package:food_project/screens/categories/desserts/cubit/cubit.dart';
import 'package:food_project/screens/categories/desserts/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';




class DessertsAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Desserts'),
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
          create: (context) => DessertsCubit()..dessertsMeals(),
          child: BlocConsumer<DessertsCubit, DessertsStates>(
            listener: (context, state) {
              if (state is DessertsStateLoading) {
                print('ChickenSandwichStateLoading');
                return buildProgress(context: context, text: "please Wait.. ");
              }
              if (state is DessertsStateSuccess) {
                print('ChickenSandwichStateSuccess');
              }
              if (state is DessertsStateError) {
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
              List desserts = DessertsCubit.get(context).desserts;
              List dessertsId = DessertsCubit.get(context).dessertsId;
              return ConditionalBuilder(
                  condition: state is DessertsStateLoading   ,
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
                                        imageUrl: desserts[index]['imageLink'].toString(),
                                        price: desserts[index]['MealPrice'].toString(),
                                        title: desserts[index]['MealTitle'].toString(),
                                        dec: desserts[index]['MealDescription'].toString(),
                                        buttonTitle: 'Delete Meal',
                                        buttonColor:Colors.red,
                                        buttonFunction: () {
                                          if (dessertsId != null) {
                                            AllMealsCubit.get(context).deleteMeal(
                                              documentId: dessertsId,
                                              index: index,
                                            );
                                            navigateTo(context,DessertsAdminScreen());
                                            showToast(text: 'Meal Deleted Successfully', error: true);

                                          }
                                        },
                                        isAdmin: true,
                                        buttonColor2: Colors.green,
                                        buttonTitle2: 'Edit Meal',
                                        buttonFunction2: (){navigateAndFinish(context, EditMealScreen(index: index,
                                          meals: desserts,
                                          mealsId: dessertsId,
                                        ),);}
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 25.0,
                                ),
                                itemCount: desserts.length,
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