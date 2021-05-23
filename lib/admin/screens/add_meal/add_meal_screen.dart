import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/home_screen.dart';
import 'package:food_project/admin/screens/add_meal/cubit/cubit.dart';
import 'package:food_project/admin/screens/add_meal/cubit/states.dart';
import 'package:food_project/shared/colors/colors.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:image_picker/image_picker.dart';
class AddMealScreen extends StatefulWidget {
  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  var titleController = TextEditingController();

  var desController = TextEditingController();

  var priceController = TextEditingController();

  var categoryController = TextEditingController();

  File image ;
  String imageLink = '';

  final picker = ImagePicker();

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        imageLink = '${pickedFile.path}';
      } else {
        showToast(text: 'No image selected.', error: true);
      }
    });
  }

  String dropdownValue = 'Appetizers';


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMealCubit,AddMealStates>(
      listener: (context,state){
        if (state is AddMealStateLoading) {
          print('Add Meal State Loading');
          return buildProgress(
              context: context,
              text: "please Wait until Adding a Meal.. "
          );
        }
        if (state is AddMealStateSuccess) {
          print('SignUpStateSuccess');
          showToast(text: 'Meal Added Successfully', error:  false );
          return navigateAndFinish(
            context,
            AdminHomeScreen(),
          );
        }
        if (state is AddMealStateError) {
          print('Add Meal State Error');
          Navigator.pop(context);
          return buildProgress(
            context: context,
            text: "${state.error.toString()}",
            error: true ,
          );
        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text('ADD YOUR MEAL'),
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
             ]
          ),
          drawer: buildAdminDrawer(context),
          body: Padding(
            padding:  EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    defaultTextBox(
                      title: "Title",
                      hint: 'Enter Title',
                      controller: titleController,
                      type: TextInputType.text,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultTextBox(
                      title: "Description",
                      hint: 'Enter Description',
                      controller: desController,
                      type: TextInputType.text,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultTextBox(
                      title: "Price",
                      hint: 'Enter Price',
                      controller: priceController,
                      type: TextInputType.text,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Choose Category',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: defaultColor,
                    ),),
                    DropdownButton<String>(
                      hint: Text("Category") ,
                     style: TextStyle(
                       fontSize: 25,
                       color: Colors.black
                     ),

                      value: dropdownValue,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['Appetizers', 'ChickenSandwich', 'FamilyMeals',
                        'BeefSandwish','Desserts','KidsMeals']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    imageLink != ''
                        ? CircleAvatar(
                      radius: 80,
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image.file(
                            File(imageLink),
                            fit: BoxFit.cover,
                          ),
                        ),
                        radius: 100,
                      ),
                    )
                        : defaultButton(
                      function: (){getImage();},
                      text: '+ Add Photo',
                      width: 150 ,
                    ),

                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16),
                      child: defaultButton(
                          function: (){
                            String title= titleController.text ;
                            String des = desController.text;
                            String price= priceController.text ;
                            String category = dropdownValue.toString();
                            if(title.isEmpty|| des.isEmpty|| price.isEmpty|| category.isEmpty|| imageLink =='')
                            {
                              showToast(text: 'please enter a valid data', error:  true );
                              return ;
                            }
                            //cubit
                            // AddMealCubit.get(context).addMeal(title: title , description: des,
                            //     category: category,price: price);
                            AddMealCubit.get(context).addMeal(imageUrl: image,title: title , description: des,
                                category: category,price: price);
                            showToast(text: 'Meal Added Successfully', error:  false );

                          },

                          text: '+ Add Meal',
                          radius: 5
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
