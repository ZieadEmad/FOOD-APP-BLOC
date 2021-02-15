import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/categories/beef/cubit/states.dart';

class BeefSCubit extends Cubit<BeefStates> {
  BeefSCubit() : super(BeefStateInitial());
  static BeefSCubit get(context) => BlocProvider.of(context);

  List beefMeals = [];
  List beefMealsId = [];

  beefMeal(){
    emit(BeefStateLoading());
    FirebaseFirestore.instance.collection('Meals')
        .where('MealCategory',isEqualTo:'BeefSandwish')
        .get().then((value){
      emit(BeefStateSuccess());
      print('$value');
      beefMeals=value.docs;
      for(var doc in value.docs ) {
        beefMealsId.add(doc.id);
      }
      print('========$beefMealsId');
    }).catchError((e){
      emit(BeefStateError(e));
    });
  }






}