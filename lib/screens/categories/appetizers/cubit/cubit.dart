import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/categories/appetizers/cubit/states.dart';

class AppetizersCubit extends Cubit<AppetizersStates> {
  AppetizersCubit() : super(AppetizersStateInitial());
  static AppetizersCubit get(context) => BlocProvider.of(context);

  List appetizersMeals = [];
  List appetizersMealsId = [];

  appetizers(){
    emit(AppetizersStateLoading());
    FirebaseFirestore.instance.collection('Meals')
        .where('MealCategory',isEqualTo:'Appetizers')
        .get().then((value){
      emit(AppetizersStateSuccess());
      print('$value');
      appetizersMeals=value.docs;
      for(var doc in value.docs ) {
        appetizersMealsId.add(doc.id);
      }
      print('========$appetizersMealsId');
    }).catchError((e){
      emit(AppetizersStateError(e));
    });
  }






}