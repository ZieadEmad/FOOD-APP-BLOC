
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/screens/add_meal/cubit/states.dart';

class AddMealCubit extends Cubit<AddMealStates> {
  String imagelink = ' ';

  AddMealCubit() : super(AddMealStateInitial());
  static AddMealCubit get(context) => BlocProvider.of(context);

   addMeal({File imageUrl,title, description, price, category}) async {
    emit(AddMealStateLoading());
    return await FirebaseStorage.instance
        .ref()
        .child('photos/${Uri.file(imageUrl.path)
        .pathSegments.last}')
        .putFile(imageUrl)
        .then((value){
          value.ref.getDownloadURL().then((value)async{
            print('${value.toString()}');
             imagelink = '${value.toString()}' ;
            emit(AddMealStateLoading());
            return await Firestore.instance.collection('Meals').add({
              'MealTitle': '${title.toString()}',
              'MealDescription': '${description.toString()}',
              'MealPrice': '${price.toString()}',
              'MealCategory': '${category.toString()}',
              'imageLink':'${imagelink.toString()}'
            }).then((value) async{
              emit(AddMealStateSuccess());

            }).catchError((e){
              emit(AddMealStateError(e.toString()));
            });
          });
      // // print('${value}');
      // print('${value.toString()}');
      // Future<DocumentReference> addMeal({ title, description, price, category}) async {
      //   emit(AddMealStateLoading());
      //   return await Firestore.instance.collection('Meals').add({
      //     'MealTitle': '${title.toString()}',
      //     'MealDescription': '${description.toString()}',
      //     'MealPrice': '${price.toString()}',
      //     'MealCategory': '${category.toString()}',
      //   }).then((value) {
      //     emit(AddMealStateSuccess());
      //
      //   }).catchError((e){
      //     emit(AddMealStateError(e.toString()));
      //   });
      // }
    });

  }

}