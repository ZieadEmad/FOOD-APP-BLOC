import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/cart/cubit/cubit.dart';
import 'package:food_project/screens/cart/cubit/states.dart';
import 'package:food_project/screens/orders/orders_screen.dart';
import 'package:food_project/screens/process_to_checkout/cubit/cubit.dart';
import 'package:food_project/screens/process_to_checkout/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';

class ProcessToCheckOutScreen extends StatelessWidget {

 final List cartMeals ;
 final  List cartMealsId ;
 ProcessToCheckOutScreen(this.cartMeals, this.cartMealsId);

 getTotalPrice(List carts) {
   int price = 0;
   if (carts.length != 0) {
     for (var i = 0; i < carts.length; i++) {
       price += int.parse(carts[i]['MealPrice'])  ;
     }
     return price;
   } else {
     return price;
   }
 }
 getTotalNames(List carts){
   List name = [] ;
   if (carts.length != 0) {
     for (var i = 0; i < carts.length; i++) {
       name.add('${carts[i]['MealTitle']} -- ');
     }
     return name;
   } else {
     return name;
   }
 }


 var phoneController = TextEditingController();
 var areaController = TextEditingController();
 var streetNameController = TextEditingController();
 var buildingNumberController = TextEditingController();
 var floorController = TextEditingController();
 var apartmentController = TextEditingController();
 var noteController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Check Out'),),
     body: MultiBlocProvider(
     providers: [
       BlocProvider(
         create: (context) => CartCubit(),
       ),
     ],
       child: BlocProvider(
         create: (context)=> AddOrderCubit() ,
         child: BlocConsumer<CartCubit,CartStates>(
           listener: (context,state){},
           builder: (context,state){
             return BlocConsumer<AddOrderCubit,OrderStates>(
               listener: (context,state){
                 if (state is AddOrderStateLoading) {
                   print('AddOrderStateLoading');
                   return buildProgress(
                       context: context,
                       text: "please Wait until Placing Order.. "
                   );
                 }
                 if (state is AddOrderStateSuccess) {
                   print('AddOrderStateSuccess');
                   Navigator.pop(context);
                   CartCubit.get(context).removeCartItems();
                   navigateAndFinish(context, UserOrdersScreen());
                 }
                 if (state is AddOrderStateError) {
                   print('AddOrderStateError');
                   Navigator.pop(context);
                   return buildProgress(
                     context: context,
                     text: "${state.error.toString()}",
                     error: true ,
                   );
                 }
               },
               builder: (context,state){
                 return Column(
                   children: [
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                       alignment: Alignment.center,
                       height: 100,
                       color: Colors.orange[100],
                       child: Text(
                         'After Your Click On Checkout And Place Order You Can Not '
                             'Change Any Personal Details & You Can Not Cancel Order',
                         style: TextStyle(
                           color: Colors.orange[800],
                           fontWeight: FontWeight.bold,
                           fontSize: 16,
                         ),
                       ),
                     ),
                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.all(16.0),
                         child: ListView(
                           children: [
                             SizedBox(height: 20,),
                             defaultTextBox(
                               title: "Phone Number",
                               hint: 'Enter your Phone Number',
                               controller: phoneController,
                               type: TextInputType.phone,
                             ),
                             SizedBox(height: 20,),
                             defaultTextBox(
                               title: "Area",
                               hint: 'Shubra-Masr / Dokki',
                               controller: areaController,
                               type: TextInputType.text,
                             ),
                             SizedBox(height: 20,),
                             defaultTextBox(
                               title: "Street Name / Number",
                               hint: 'Enter Street Name',
                               controller: streetNameController,
                               type: TextInputType.text,
                             ),
                             SizedBox(height: 20,),
                             defaultTextBox(
                               title: "building Number",
                               hint: '26',
                               controller: buildingNumberController,
                               type: TextInputType.number,
                             ),
                             SizedBox(height: 20,),
                             defaultTextBox(
                               title: "Floor Number",
                               hint: '4',
                               controller: floorController,
                               type: TextInputType.number,
                             ),
                             SizedBox(height: 20,),
                             defaultTextBox(
                               title: "Apartment Number",
                               hint: '35',
                               controller: apartmentController,
                               type: TextInputType.text,
                             ),
                             SizedBox(height: 20,),
                             defaultTextBox(
                               title: "Note on request",
                               hint: 'With Out Onion',
                               controller: noteController,
                               type: TextInputType.text,
                             ),

                           ],
                         ),
                       ),
                     ),
                     SizedBox(height: 20,),
                     Container(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text('Total Price:',style: TextStyle(fontSize: 20),),
                               SizedBox(width: 5,),
                               Text('${getTotalPrice(cartMeals)} L.E',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                             ],
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 30,right: 30,bottom: 15,top: 5),
                             child: defaultButton(
                               function: () {
                                 String userName = FirebaseAuth.instance.currentUser.displayName;
                                 String name= userName.toString() ;
                                 String phone = phoneController.text;
                                 String area = areaController.text;
                                 String streetName= streetNameController.text ;
                                 String buildingNumber = buildingNumberController.text;
                                 String floorNumber= floorController.text ;
                                 String apartmentNumber = apartmentController.text;
                                 String note = noteController.text;
                                 if(
                                 name.isEmpty|| area.isEmpty|| streetName.isEmpty ||
                                     buildingNumber.isEmpty|| floorNumber.isEmpty ||
                                     apartmentNumber.isEmpty|| phone.isEmpty
                                 )
                                 {
                                   showToast(text: 'please enter a valid data', error:  true );
                                   return ;
                                 }
                                 List totalNames = getTotalNames(cartMeals);
                                 String finalNames = totalNames.join("");
                                 //cubit
                                 AddOrderCubit.get(context).addOrder(
                                   name: name.toString(),
                                   area: area.toString(),
                                   street: streetName.toString(),
                                   building: buildingNumber.toString(),
                                   floor: floorNumber.toString(),
                                   apartment: apartmentNumber.toString(),
                                   phone: phone.toString(),
                                   note: note.toString(),
                                   orderName: finalNames.toString(),
                                   totalPrice: getTotalPrice(cartMeals).toString(),
                                 );
                                 showToast(text: 'Your Order confirmed', error:  false );
                               },
                               text: 'checkout and place order',
                               background: Colors.green,
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 );
               },
             );
           },
         ),
       ),
     ),
    );
  }
}
