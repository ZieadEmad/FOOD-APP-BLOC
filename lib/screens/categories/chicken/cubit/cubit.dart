import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/categories/chicken/cubit/state.dart';

class ChickenSandwichCubit extends Cubit<ChickenSandwichStates> {
  ChickenSandwichCubit() : super(ChickenSandwichStateInitial());
  static ChickenSandwichCubit get(context) => BlocProvider.of(context);

  List chickenMeals = [];
  List chickenMealsId = [];

  chickenSandwich(){
    emit(ChickenSandwichStateLoading());
    FirebaseFirestore.instance.collection('Meals')
        .where('MealCategory',isEqualTo:'ChickenSandwich')
        .get().then((value){
      emit(ChickenSandwichStateSuccess());
      print('$value');
      chickenMeals=value.docs;
      for(var doc in value.docs ) {
        chickenMealsId.add(doc.id);
      }
      print('========$chickenMealsId');
    }).catchError((e){
      emit(ChickenSandwichStateError(e));
    });
  }






}