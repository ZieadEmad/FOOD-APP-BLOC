




import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/screens/orders/cubit/state.dart';
import 'package:food_project/shared/network/remote/dio_helper.dart';

class ShowAdminOrderCubit extends Cubit<ShowAdminOrderStates> {
  ShowAdminOrderCubit() : super(ShowAdminOrderStateInitial());
  static ShowAdminOrderCubit get(context) => BlocProvider.of(context);

  List adminOrderMeals = [];
  List adminOrderMealsId = [];
  bool canDelete = true ;

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

  canUserDeleteOrder({bool cant= true}){
    if(cant==true){
      canDelete = true;
    }
  else{
      canDelete = false;
    }
  }

  Future<void> deleteMeal({documentId,index}) async {
    return await FirebaseFirestore.instance.collection('Orders')
        .doc(documentId[index].toString())
        .delete();
  }

  editOrderCancel(documentId,index)async{
    emit(ShowAdminOrderStateLoading());
    return await FirebaseFirestore.instance.collection('Orders')
        .doc(documentId[index].toString())
        .update({
      'canCancel':'false',
    }).then((value) {
      emit(ShowAdminOrderStateSuccess());
    }).catchError((e){
      emit(ShowAdminOrderStateError(e));
    });
  }


  sendConfirm({token})async{
    http.post(
      Uri.https('fcm.googleapis.com', 'fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
        'key=AAAA1k17ojI:APA91bH7Nkq3gRjWJNn-Ix48rBF9O9vKi-Ev0yb0VCddugXqbQXcKaOsq5yN8mxL2nsB1XtrHQdTAN15KCZ3TLuzRoNj1kOemxhFDkadpcznd3lLx36ZhWc8mwwVLolwj29Q_RI_j17D'
      },
      body: jsonEncode({
        "to": "$token",
        "collapse_key": "type_a",
        "notification": {
          "body": "The Restaurant Accept Your Order",
          "title": "Message From Tasty-Restaurant",
        },
        "data": {
          "body": "Body : Data",
          "title": "Title : Data",
          "image": " "
        }
      }),
    ).then((value) {
      print('=======success');
      emit(NotificationsStateSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(NotificationsStateError(e.toString()));
    });
  }

  sendFinish({token})async{
    http.post(
      Uri.https('fcm.googleapis.com', 'fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
        'key=AAAA1k17ojI:APA91bH7Nkq3gRjWJNn-Ix48rBF9O9vKi-Ev0yb0VCddugXqbQXcKaOsq5yN8mxL2nsB1XtrHQdTAN15KCZ3TLuzRoNj1kOemxhFDkadpcznd3lLx36ZhWc8mwwVLolwj29Q_RI_j17D'
      },
      body: jsonEncode({
        "to": "$token",
        "collapse_key": "type_a",
        "notification": {
          "body": "Your Order Finish And Delivery Man On His Way",
          "title": "Message From Tasty-Restaurant",
        },
        "data": {
          "body": "Body : Data",
          "title": "Title : Data",
          "image": " "
        }
      }),
    ).then((value) {
      print('=======success');
      emit(NotificationsStateSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(NotificationsStateError(e.toString()));
    });
  }


}