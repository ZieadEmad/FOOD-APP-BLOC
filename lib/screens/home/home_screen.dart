import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/all_meals_cubit/cubit.dart';
import 'package:food_project/admin/all_meals_cubit/states.dart';
import 'package:food_project/screens/cart/cubit/cubit.dart';
import 'package:food_project/screens/cart/cubit/states.dart';
import 'package:food_project/screens/categories/appetizers/appetizers_screen.dart';
import 'package:food_project/screens/categories/beef/beef_screen.dart';
import 'package:food_project/screens/categories/chicken/chicken_screen.dart';
import 'package:food_project/screens/categories/desserts/desserts_screen.dart';
import 'package:food_project/screens/categories/family/family_screen.dart';
import 'package:food_project/screens/categories/kids/kids_screen.dart';
import 'package:food_project/screens/welcome/welcome_screen.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:food_project/shared/network/local/local.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  String token ;

  @override
  void initState() {
    super.initState();
    firebaseCloudMessage();
  }

  void firebaseCloudMessage(){
    firebaseMessaging.getToken().then((value) {
      print('token==========$value');
      token=value.toString();
      setState(() {
        saveUserToken(token.toString());
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(),
        ),
      ],
      child: BlocProvider(
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
                  fallback: (context)=> BlocConsumer<CartCubit,CartStates>(
                    listener: (context,state){},
                    builder: (context,state){
                      return ListView(
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
                                  '${meals[0]['MealCategory']}',
                                  '${meals[0]['imageLink']}',
                                  '${meals[0]['MealTitle']}',
                                  '${meals[0]['MealPrice']} L.E',
                                      () {navigateTo(context, AppetizersScreen());},
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                buildPopularItem(
                                  '${meals[1]['MealCategory']}',
                                  '${meals[1]['imageLink']}',
                                  '${meals[1]['MealTitle']}',
                                  '${meals[1]['MealPrice']} L.E',
                                      () {navigateTo(context, ChickenScreen());},
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                buildPopularItem(
                                  '${meals[2]['MealCategory']}',
                                  '${meals[2]['imageLink']}',
                                  '${meals[2]['MealTitle']}',
                                  '${meals[2]['MealPrice']} L.E',
                                      () {navigateTo(context, FamilyScreen());},
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                buildPopularItem(
                                  '${meals[3]['MealCategory']}',
                                  '${meals[3]['imageLink']}',
                                  '${meals[3]['MealTitle']}',
                                  '${meals[3]['MealPrice']} L.E',
                                      () {navigateTo(context, BeefScreen());},
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                buildPopularItem(
                                  '${meals[4]['MealCategory']}',
                                  '${meals[4]['imageLink']}',
                                  '${meals[4]['MealTitle']}',
                                  '${meals[4]['MealPrice']} L.E',
                                      () {navigateTo(context, DessertsScreen());},
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                buildPopularItem(
                                  '${meals[5]['MealCategory']}',
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
                                (){
                              CartCubit.get(context).addCart(mealsId[0]);
                              showToast(text: 'Item Added Successfully', error: false);
                                },
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
                                (){
                              CartCubit.get(context).addCart(mealsId[1]);
                              showToast(text: 'Item Added Successfully', error: false);
                                },
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
                                (){
                              CartCubit.get(context).addCart(mealsId[2]);
                              showToast(text: 'Item Added Successfully', error: false);
                              },
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
                                (){
                              CartCubit.get(context).addCart(mealsId[3]);
                              showToast(text: 'Item Added Successfully', error: false);
                              },
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
                                (){
                              CartCubit.get(context).addCart(mealsId[4]);
                              showToast(text: 'Item Added Successfully', error: false);
                                },
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
                                (){
                              CartCubit.get(context).addCart(mealsId[5]);
                              showToast(text: 'Item Added Successfully', error: false);
                              },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator(),),
              ),
            );
          },
        ),
      ),
    );
  }
}
