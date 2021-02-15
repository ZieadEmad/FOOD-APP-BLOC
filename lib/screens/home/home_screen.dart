import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/all_meals_cubit/cubit.dart';
import 'package:food_project/admin/all_meals_cubit/states.dart';
import 'package:food_project/screens/categories/appetizers/appetizers_screen.dart';
import 'package:food_project/screens/categories/beef/beef_screen.dart';
import 'package:food_project/screens/categories/chicken/chicken_screen.dart';
import 'package:food_project/screens/categories/desserts/desserts_screen.dart';
import 'package:food_project/screens/categories/family/family_screen.dart';
import 'package:food_project/screens/categories/kids/kids_screen.dart';
import 'package:food_project/screens/welcome/welcome_screen.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:food_project/shared/network/local/local.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllMealsCubit()..allMeals(),
      child: BlocConsumer<AllMealsCubit, AllMealsStates>(
        listener: (context, state) {
          if (state is AllMealsStateLoading) {
            print('AllMealsStateLoading');
            return buildProgress(context: context, text: "please Wait.. ");
          }
          if (state is AllMealsStateSuccess) {
            print('AllMealsStateSuccess');
          }
          if (state is AllMealsStateError) {
            print('AllMealsStateError');
            Navigator.pop(context);
            return buildProgress(
              context: context,
              text: "${state.error.toString()}",
              error: true,
            );
          }
        },
        builder: (context, state) {
          List meals = AllMealsCubit.get(context).meals;
          List mealsId = AllMealsCubit.get(context).mealsID;
          return Scaffold(
            body: ConditionalBuilder(
              condition: meals != null  ,
              builder: (context) => ConditionalBuilder(
                condition: state is AllMealsStateLoading,
                builder: (context)=> Center(child: CircularProgressIndicator(),),
                fallback: (context)=> ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Categories',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 150,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          buildCategoryItem(
                          'assets/images/chicken-leg.png',
                            'Chicken Sandwichs',
                            context,
                            () {navigateAndFinish(context, ChickenScreen());},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          buildCategoryItem(
                            'assets/images/burger.png',
                            'Beef Sandwichs',
                            context,
                            () {navigateAndFinish(context, BeefScreen());},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          buildCategoryItem(
                            'assets/images/eid-al-fitr.png',
                            'Family Meals',
                            context,
                            () {navigateAndFinish(context, FamilyScreen());},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          buildCategoryItem(
                            'assets/images/boy.png',
                            'Kids Meals',
                            context,
                                () {navigateAndFinish(context, KidsScreen());},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          buildCategoryItem(
                            'assets/images/appetizer.png',
                            'Appetizers',
                            context,
                                () {navigateAndFinish(context, AppetizersScreen());},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          buildCategoryItem(
                            'assets/images/cake.png',
                            'Desserts',
                            context,
                                () {navigateAndFinish(context, DessertsScreen());},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Popular Dishes',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 250,
                      width: 100,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          buildPopularItem(
                            'Appetizers',
                            '${meals[0]['imageLink']}',
                            '${meals[0]['MealTitle']}',
                            '${meals[0]['MealPrice']} L.E',
                                () {navigateTo(context, AppetizersScreen());},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          buildPopularItem(
                            'Chicken Sandwichs',
                            '${meals[1]['imageLink']}',
                            '${meals[1]['MealTitle']}',
                            '${meals[1]['MealPrice']} L.E',
                                () {navigateTo(context, ChickenScreen());},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          buildPopularItem(
                            'Family Meals',
                            '${meals[2]['imageLink']}',
                            '${meals[2]['MealTitle']}',
                            '${meals[2]['MealPrice']} L.E',
                                () {navigateTo(context, FamilyScreen());},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          buildPopularItem(
                            'Beef Sandwichs',
                            '${meals[3]['imageLink']}',
                            '${meals[3]['MealTitle']}',
                            '${meals[3]['MealPrice']} L.E',
                                () {navigateTo(context, BeefScreen());},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          buildPopularItem(
                            'Desserts',
                            '${meals[4]['imageLink']}',
                            '${meals[4]['MealTitle']}',
                            '${meals[4]['MealPrice']} L.E',
                                () {navigateTo(context, DessertsScreen());},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          buildPopularItem(
                            'Kids Meals',
                            '${meals[5]['imageLink']}',
                            '${meals[5]['MealTitle']}',
                            '${meals[5]['MealPrice']} L.E',
                                () {navigateTo(context, KidsScreen());},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'New Dishes',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    buildCard(
                      '${meals[0]['imageLink']}',
                      '${meals[0]['MealTitle']}',
                      '${meals[0]['MealPrice']} L.E',
                      () {},
                      '${meals[0]['MealDescription']}',
                          (){},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      '${meals[1]['imageLink']}',
                      '${meals[1]['MealTitle']}',
                      '${meals[1]['MealPrice']} L.E',
                      () {},
                      '${meals[1]['MealDescription']}',
                          (){},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      '${meals[2]['imageLink']}',
                      '${meals[2]['MealTitle']}',
                      '${meals[2]['MealPrice']} L.E',
                      () {},
                      '${meals[2]['MealDescription']}',
                          (){},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      '${meals[3]['imageLink']}',
                      '${meals[3]['MealTitle']}',
                      '${meals[3]['MealPrice']} L.E',
                      () {},
                      '${meals[3]['MealDescription']}',
                          (){},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      '${meals[4]['imageLink']}',
                      '${meals[4]['MealTitle']}',
                      '${meals[4]['MealPrice']} L.E',
                      () {},
                      '${meals[4]['MealDescription']}',
                          (){},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      '${meals[5]['imageLink']}',
                      '${meals[5]['MealTitle']}',
                      '${meals[5]['MealPrice']} L.E',
                      () {},
                      '${meals[5]['MealDescription']}',
                          (){},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: FlatButton(
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
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator(),),
            ),
          );
        },
      ),
    );
  }
}
// appBar: AppBar(
//   title: Text('HOME PAGE'),
//   actions: [
//     FlatButton(
//         onPressed: () {
//           removeToken();
//           navigateAndFinish(context, WelcomeScreen());
//         },
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 4,
//               ),
//               Icon(Icons.logout, color: Colors.black),
//               SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 'LOG OUT',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         )),
//   ],
// ),
