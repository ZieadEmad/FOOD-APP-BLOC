import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/all_meals_cubit/states.dart';

class AllMealsCubit extends Cubit<AllMealsStates> {
  AllMealsCubit() : super(AllMealsStateInitial());
  static AllMealsCubit get(context) => BlocProvider.of(context);

List meals = [];
List mealsID = [];

allMeals(){
  emit(AllMealsStateLoading());
  FirebaseFirestore.instance.collection('Meals').get().then((value){
    emit(AllMealsStateSuccess());
    print('${value}');
    meals=value.docs;
    var index = 0 ;
    for(var doc in value.docs ) {
      var data = doc.data();
      mealsID.add(doc.id);

    }
    print('========${mealsID}');
  }).catchError((e){
    emit(AllMealsStateError(e));
  });
}


editMeal({documentId,index,mealDec,mealPrice,mealTitle})async{
      emit(EditMealsStateLoading());
      return await FirebaseFirestore.instance.collection('Meals')
          .doc(documentId[index].toString())
          .update({

        'MealDescription':'$mealDec',
        'MealPrice':'$mealPrice',
        'MealTitle':'$mealTitle',

      }).then((value) {

      emit(EditMealsStateSuccess());

      }).catchError((e){
        emit(EditMealsStateError(e));
      });
}

 Future<void> deleteMeal({documentId,index}) async {
   return await FirebaseFirestore.instance.collection('Meals')
      .doc(documentId[index].toString())
      .delete().then((value) {
     emit(DeleteMealsStateSuccess());
   });
}

  deleteMealFromScreen(index){
    FirebaseFirestore.instance.collection('Meals').get().then((value){
      emit(AllMealsStateSuccess());
      meals.removeAt(index);
      print('sucesssssss');
    }).catchError((e){
      emit(AllMealsStateError(e));
    });
  }

}


