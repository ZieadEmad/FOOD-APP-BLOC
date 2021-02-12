import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/screens/all_meals_cubit/states.dart';

class AllMealsCubit extends Cubit<AllMealsStates>
{
  AllMealsCubit() : super(AllMealsStateInitial());
  static AllMealsCubit get(context) => BlocProvider.of(context);

List meals = [];


allMeals(){
  emit(AllMealsStateLoading());
  FirebaseFirestore.instance.collection('Meals').getDocuments().then((value){
    emit(AllMealsStateSuccess());
    print('${value}');
    meals=value.docs;
    print('${meals}');
    print('sucesssssss');
  }).catchError((e){
    emit(AllMealsStateError(e));
  });
}

deleteMeal(index){
   FirebaseFirestore.instance.collection('Meals').get().then((value){
    emit(AllMealsStateSuccess());
      meals.removeAt(index);
    print('sucesssssss');
   }).catchError((e){
     emit(AllMealsStateError(e));
   });
}

}


