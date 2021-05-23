import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/all_meals_cubit/cubit.dart';
import 'package:food_project/admin/all_meals_cubit/states.dart';
import 'package:food_project/admin/home_screen.dart';
import 'package:food_project/shared/componentes/components.dart';

class EditMealScreen extends StatelessWidget {
  List meals ;
  List mealsId ;
  int index ;

  EditMealScreen({this.meals, this.mealsId, this.index});

  var titleController = TextEditingController();
  var desController = TextEditingController();
  var priceController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appetizers'),
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
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: ListView(
          children: [
            BlocProvider(
              create: (context)=> AllMealsCubit(),
              child: BlocConsumer<AllMealsCubit,AllMealsStates>(
                listener: (context,state){},
                builder: (context,state){
                  return Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      defaultTextBox(
                        title: "Meal Description",
                        hint: 'Enter New Description',
                        controller: desController,
                        type: TextInputType.text,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextBox(
                        title: "Meal Price",
                        hint: 'Enter New Price',
                        controller: priceController,
                        type: TextInputType.text,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextBox(
                        title: "Meal Title",
                        hint: 'Enter New Title',
                        controller: titleController,
                        type: TextInputType.text,
                      ),
                      SizedBox(height: 200,),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16,),
                        child: defaultButton(
                            function: (){

                              String des ;
                              String title;
                              String price;

                              if(desController.text.isEmpty){
                                des = meals[index]['MealDescription'].toString();
                              }
                              else {
                                des = desController.text;
                              }

                              if(titleController.text.isEmpty){
                                title = meals[index]['MealTitle'].toString();
                              }
                              else {
                                title = titleController.text;
                              }

                              if(priceController.text.isEmpty){
                                price = meals[index]['MealPrice'].toString();
                              }
                              else {
                                price = priceController.text;
                              }

                              AllMealsCubit.get(context).editMeal(
                                index: index,
                                documentId: mealsId,
                                mealDec: des.toString(),
                                mealPrice: price.toString(),
                                mealTitle: title.toString(),
                              );

                              showToast(text: 'Meal Edited Successfully' , error: false);
                              navigateAndFinish(context, AdminHomeScreen());
                            },
                            text: 'Edit Meal',
                            radius: 5
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
