import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/categories/appetizers/cubit/cubit.dart';
import 'package:food_project/screens/categories/appetizers/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';

class AppetizersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appetizers'),
        actions: [
          SizedBox(width: 10,),
          InkWell(
            onTap: (){navigateAndFinish(context, LayoutScreen());},
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.home,color: Colors.white,),
                  Text('HOME'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => AppetizersCubit()..appetizers(),
        child: BlocConsumer<AppetizersCubit, AppetizersStates>(
          listener: (context, state) {
            if (state is AppetizersStateLoading) {
              print('ChickenSandwichStateLoading');
              return buildProgress(context: context, text: "please Wait.. ");
            }
            if (state is AppetizersStateSuccess) {
              print('ChickenSandwichStateSuccess');
            }
            if (state is AppetizersStateError) {
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
            List appetizersMeals = AppetizersCubit.get(context).appetizersMeals;
            List chickenMealsId = AppetizersCubit.get(context).appetizersMealsId;
            return ConditionalBuilder(
              condition: state is AppetizersStateLoading   ,
              builder: (context) => Center(child: CircularProgressIndicator(),),
              fallback:(context) =>Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        itemBuilder: (context, index) =>
                            buildMealItems(
                                imageUrl: appetizersMeals[index]['imageLink'].toString(),
                                price: appetizersMeals[index]['MealPrice'].toString(),
                                title: appetizersMeals[index]['MealTitle'].toString(),
                                dec: appetizersMeals[index]['MealDescription'].toString(),
                                buttonFunction: (){}
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 25.0,
                        ),
                        itemCount: appetizersMeals.length,
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
