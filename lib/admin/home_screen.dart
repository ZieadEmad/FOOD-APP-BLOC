
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/screens/add_meal/add_meal_screen.dart';
import 'package:food_project/admin/screens/all_meals_cubit/cubit.dart';
import 'package:food_project/admin/screens/all_meals_cubit/states.dart';
import 'package:food_project/screens/welcome/welcome_screen.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:food_project/shared/network/local/local.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Meals'),
        actions: [
          FlatButton(
              onPressed: () {
                navigateTo(context, AddMealScreen());
              },
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.green[800],
                      size: 25,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'ADD NEW MEALS',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )),
          FlatButton(
              onPressed: () {
                removeToken();
                navigateAndFinish(context, WelcomeScreen());
              },
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Icon(Icons.logout, color: Colors.black),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'LOG OUT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )),
        ],
      ),
      body: BlocProvider(
        create: (context) => AllMealsCubit()..allMeals(),
        child: BlocConsumer<AllMealsCubit,AllMealsStates>(
          listener: (context,state){},
          builder:  (context,state){
            List meals = AllMealsCubit.get(context).meals;
            return Padding(
              padding:  EdgeInsets.all(16.0),
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Card(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name : ${meals[position]['MealTitle']}',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Description: ${meals[position]['MealDescription']} ',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Price: ${meals[position]['MealPrice']}',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Category: ${meals[position]['MealCategory']}',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey.shade400,
                            ),
                            Center(
                              child: Image.network(
                                // '${meals[position]['MealImageUrl']}',
                                'https://cdn.sanity.io/images/lg38muzm/production/7385bd8a1262b50f88e0c7670a9927f7f476a027-1133x740.png?w=800&h=523&fit=crop',
                                height: 250,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Center(
                                child: defaultButton(
                                    function: () {
                                      AllMealsCubit.get(context).deleteMeal(position);
                                    },
                                    text: 'Delete Meal',
                                    background: Colors.red)),

                            //   Image.file(File('')),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: meals.length,
              ),
            );
          },

        ),
      ),
    );
  }
}
