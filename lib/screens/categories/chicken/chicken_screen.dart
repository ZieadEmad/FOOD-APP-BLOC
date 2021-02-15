import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/categories/chicken/cubit/cubit.dart';
import 'package:food_project/screens/categories/chicken/cubit/state.dart';
import 'package:food_project/shared/componentes/components.dart';

class ChickenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chicken Sandwichs'),
        actions: [
          SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
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
          ),
          SizedBox(width: 10,),

        ],
      ),
      body: BlocProvider(
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
            List chickenMeals = ChickenSandwichCubit.get(context).chickenMeals;
            List chickenMealsId =
                ChickenSandwichCubit.get(context).chickenMealsId;
            return ConditionalBuilder(
              condition: state is ChickenSandwichStateLoading   ,
              builder: (context) => Center(child: CircularProgressIndicator(),),
                fallback:(context) =>Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          itemBuilder: (context, index) =>
                              buildMealItems(
                                  imageUrl: chickenMeals[index]['imageLink'].toString(),
                                  price: chickenMeals[index]['MealPrice'].toString(),
                                  title: chickenMeals[index]['MealTitle'].toString(),
                                  dec: chickenMeals[index]['MealDescription'].toString(),
                                  buttonFunction: (){}
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
                    ]),
            );
          },
        ),
      ),
    );
  }
}

