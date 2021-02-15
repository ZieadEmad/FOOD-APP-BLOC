import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/categories/family/cubit/states.dart';

class FamilyMealsCubit extends Cubit<FamilyMealsStates> {
  FamilyMealsCubit() : super(FamilyMealsStateInitial());
  static FamilyMealsCubit get(context) => BlocProvider.of(context);

  List familyMeals = [];
  List familyMealsId = [];

  familyMeal(){
    emit(FamilyMealsStateLoading());
    FirebaseFirestore.instance.collection('Meals')
        .where('MealCategory',isEqualTo:'FamilyMeals')
        .get().then((value){
      emit(FamilyMealsStateSuccess());
      print('$value');
      familyMeals=value.docs;
      for(var doc in value.docs ) {
        familyMealsId.add(doc.id);
      }
      print('========$familyMealsId');
    }).catchError((e){
      emit(FamilyMealsStateError(e));
    });
  }






}