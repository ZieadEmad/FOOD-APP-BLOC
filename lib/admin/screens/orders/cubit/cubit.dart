





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/screens/orders/cubit/state.dart';

class ShowAdminOrderCubit extends Cubit<ShowAdminOrderStates> {
  ShowAdminOrderCubit() : super(ShowAdminOrderStateInitial());
  static ShowAdminOrderCubit get(context) => BlocProvider.of(context);

  List adminOrderMeals = [];
  List adminOrderMealsId = [];

  showOrdersUser(){
    emit(ShowAdminOrderStateLoading());
    FirebaseFirestore.instance.collection('Orders').orderBy('DateAndTimeAdmin', descending: true).get().then((value){
      emit(ShowAdminOrderStateSuccess());
      print('$value');
      for(var doc in value.docs ) {
        adminOrderMeals.add(doc.data());
      }
      for(var doc in value.docs ) {
        adminOrderMealsId.add(doc.id);
      }
      print('========$adminOrderMeals');
      print('========$adminOrderMealsId');
    }).catchError((e){
      emit(ShowAdminOrderStateError(e));
    });
  }


  Future<void> deleteMeal({documentId,index}) async {
    return await FirebaseFirestore.instance.collection('Orders')
        .doc(documentId[index].toString())
        .delete();
  }


}