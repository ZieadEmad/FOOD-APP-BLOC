import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/cart/cubit/states.dart';
import 'package:food_project/shared/network/local/local.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartStateInitial());
  static CartCubit get(context) => BlocProvider.of(context);

  List cartMeals = [];
  List cartMealsId = [];

  addCart(String id){
    emit(AddCartStateLoading());
    FirebaseFirestore.instance.collection('Meals')
        .get().then((value){
      for(var doc in value.docs ) {
        if(id == doc.id){
          var id =doc.id ;
          var data = doc.data();
          Firestore.instance.collection('Cart').add({
            'MealTitle': '${data['MealTitle']}',
            'MealDescription': '${data['MealDescription']}}',
            'MealPrice': '${data['MealPrice']}',
            'MealCategory': '${data['MealCategory']}',
            'imageLink':'${data['imageLink']}',
            'UserId' : '${getToken()}',
            'MealId' : '$id',
          }).then((value) async{
            emit(AddCartStateSuccess());
          }).catchError((e){
            emit(AddCartStateError(e.toString()));
          });
        }
      }
    }).catchError((e){
      emit(AddCartStateError(e));
    });
  }

  showCart(){
    emit(ShowCartStateLoading());
    FirebaseFirestore.instance.collection('Cart').get().then((value){
      emit(ShowCartStateSuccess());
      print('$value');
      cartMeals=value.docs;
      for(var doc in value.docs ) {
        cartMealsId.add(doc.id);
      }
      print('========$cartMealsId');
    }).catchError((e){
      emit(ShowCartStateError(e));
    });
  }


  Future<void> deleteMeal({documentId,index}) async {
    return await FirebaseFirestore.instance.collection('Cart')
        .doc(documentId[index].toString())
        .delete();
  }


}

