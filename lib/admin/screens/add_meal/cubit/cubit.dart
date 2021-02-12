
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/screens/add_meal/cubit/states.dart';

class AddMealCubit extends Cubit<AddMealStates>
{
  AddMealCubit() : super(AddMealStateInitial());
  static AddMealCubit get(context) => BlocProvider.of(context);

    Future<DocumentReference> addMeal({imageUrl, title, description, price, category}) async {
      emit(AddMealStateLoading());
      return await Firestore.instance.collection('Meals').add({
        'MealImageUrl': '${imageUrl.toString()}',
        'MealTitle': '${title.toString()}',
        'MealDescription': '${description.toString()}',
        'MealPrice': '${price.toString()}',
        'MealCategory': '${category.toString()}',
      }).then((value) {
        emit(AddMealStateSuccess());
      }).catchError((e){
        emit(AddMealStateError(e.toString()));
      });
    }


}