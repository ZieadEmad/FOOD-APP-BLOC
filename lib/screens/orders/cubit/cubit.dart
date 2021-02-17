
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/orders/cubit/states.dart';
import 'package:food_project/shared/network/local/local.dart';

class ShowOrderCubit extends Cubit<ShowOrderStates> {
  ShowOrderCubit() : super(ShowOrderStateInitial());
  static ShowOrderCubit get(context) => BlocProvider.of(context);

  List orderMeals = [];
  List orderMealsId = [];

  showOrdersUser(){
    emit(ShowOrderStateLoading());
    FirebaseFirestore.instance.collection('Orders').get().then((value){
      emit(ShowOrderStateSuccess());
      print('$value');
      for(var doc in value.docs ) {
        if(doc['UserId']==getToken().toString()){
          orderMeals.add(doc.data());
        }
      }
      // cartMeals=value.docs;
      for(var doc in value.docs ) {
        if(doc['UserId']==getToken().toString()){
          orderMealsId.add(doc.id);
        }
        // cartMealsId.add(doc.id);
      }
      print('========$orderMealsId');
    }).catchError((e){
      emit(ShowOrderStateError(e));
    });
  }


  Future<void> deleteMeal({documentId,index}) async {
    return await FirebaseFirestore.instance.collection('Cart')
        .doc(documentId[index].toString())
        .delete();
  }


}