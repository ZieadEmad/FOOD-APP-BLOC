import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/categories/desserts/cubit/states.dart';

class DessertsCubit extends Cubit<DessertsStates> {
  DessertsCubit() : super(DessertsStateInitial());
  static DessertsCubit get(context) => BlocProvider.of(context);

  List desserts = [];
  List dessertsId = [];

  dessertsMeals(){
    emit(DessertsStateLoading());
    FirebaseFirestore.instance.collection('Meals')
        .where('MealCategory',isEqualTo:'Desserts')
        .get().then((value){
      emit(DessertsStateSuccess());
      print('$value');
      desserts=value.docs;
      for(var doc in value.docs ) {
        dessertsId.add(doc.id);
      }
      print('========$dessertsId');
    }).catchError((e){
      emit(DessertsStateError(e));
    });
  }






}