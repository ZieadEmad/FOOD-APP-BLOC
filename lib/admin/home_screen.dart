import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/all_meals_cubit/cubit.dart';
import 'package:food_project/admin/all_meals_cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL Meals'),
        // actions: [
        //   FlatButton(
        //       onPressed: () {
        //         navigateTo(context, AddMealScreen());
        //       },
        //       child: Center(
        //         child: Column(
        //           children: [
        //             SizedBox(
        //               height: 4,
        //             ),
        //             Icon(
        //               Icons.add,
        //               color: Colors.green[800],
        //               size: 25,
        //             ),
        //             SizedBox(
        //               height: 4,
        //             ),
        //             Text(
        //               'ADD NEW MEALS',
        //               style: TextStyle(color: Colors.white),
        //             ),
        //           ],
        //         ),
        //       )),
        //   // FlatButton(
        //   //     onPressed: () {
        //   //       removeToken();
        //   //       navigateAndFinish(context, WelcomeScreen());
        //   //     },
        //   //     child: Center(
        //   //       child: Column(
        //   //         children: [
        //   //           SizedBox(
        //   //             height: 4,
        //   //           ),
        //   //           Icon(Icons.logout, color: Colors.black),
        //   //           SizedBox(
        //   //             height: 5,
        //   //           ),
        //   //           Text(
        //   //             'LOG OUT',
        //   //             style: TextStyle(color: Colors.white),
        //   //           ),
        //   //         ],
        //   //       ),
        //   //     )),
        // ],
      ),
      drawer: buildAdminDrawer(context),
      body: BlocProvider(
        create: (context) => AllMealsCubit()..allMeals(),
        child: BlocConsumer<AllMealsCubit, AllMealsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            List meals = AllMealsCubit.get(context).meals;
            List mealsId = AllMealsCubit.get(context).mealsID;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
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
                                '${meals[position]['imageLink']}',
                                height: 250,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Center(
                                child: defaultButton(
                                    function: () {
                                      // AllMealsCubit.get(context).deleteMealFromScreen(position);
                                      if (mealsId != null) {
                                        AllMealsCubit.get(context).deleteMeal(
                                            documentId: mealsId,
                                            index: position);
                                        navigateAndFinish(context, AdminHomeScreen());
                                      }

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

