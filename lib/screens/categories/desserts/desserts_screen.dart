import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/categories/desserts/cubit/cubit.dart';
import 'package:food_project/screens/categories/desserts/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';

class DessertsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Desserts'),
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
            ),
          ),
        ],
      ),
      body: BlocProvider(
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
              fallback:(context) =>Column(
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
                                buttonFunction: (){}
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
                  ]),
            );
          },
        ),
      ),
    );
  }
}
