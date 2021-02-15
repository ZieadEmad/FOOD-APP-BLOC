import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/categories/family/cubit/cubit.dart';
import 'package:food_project/screens/categories/family/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';

class FamilyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Family Meals'),
        actions: [
          SizedBox(width: 10,),
      InkWell(
        onTap: (){navigateTo(context, LayoutScreen());},
        child: Center(
          child: Column(
            children: [
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){navigateTo(context, LayoutScreen());},
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.home,color: Colors.white,),
                        Text('HOME'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10,),

            ],
          ),
        ),
      ),
      ],
      ),
      body: BlocProvider(
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
              fallback:(context) =>Column(
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
                                buttonFunction: (){}
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
                  ]),
            );
          },
        ),
      ),
    );
  }
}
