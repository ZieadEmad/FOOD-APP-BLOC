import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/categories/kids/cubit/states.dart';

class KidsMealsCubit extends Cubit<KidsMealsStates> {
  KidsMealsCubit() : super(KidsMealsStateInitial());
  static KidsMealsCubit get(context) => BlocProvider.of(context);

  List kidsMeals = [];
  List kidsMealsId = [];

  kidsMeal(){
    emit(KidsMealsStateLoading());
    FirebaseFirestore.instance.collection('Meals')
        .where('MealCategory',isEqualTo:'KidsMeals')
        .get().then((value){
      emit(KidsMealsStateSuccess());
      print('$value');
      kidsMeals=value.docs;
      for(var doc in value.docs ) {
        kidsMealsId.add(doc.id);
      }
      print('========$kidsMealsId');
    }).catchError((e){
      emit(KidsMealsStateError(e));
    });
  }






}