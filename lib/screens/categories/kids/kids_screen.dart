import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/categories/kids/cubit/cubit.dart';
import 'package:food_project/screens/categories/kids/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';

class KidsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kids Meals'),
        actions: [
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
      body: BlocProvider(
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
              fallback:(context) =>Column(
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
                                buttonFunction: (){}
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
                  ]),
            );
          },
        ),
      ),
    );
  }
}
