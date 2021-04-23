
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/screens/tables/cubit/states.dart';

class ShowAdminTableCubit extends Cubit<ShowAdminTableStates> {
  ShowAdminTableCubit() : super(ShowAdminTableStateInitial());
  static ShowAdminTableCubit get(context) => BlocProvider.of(context);

  List adminTables = [];
  List adminTablesId = [];
  bool canDelete = true ;

  showTablesAdmin(){
    emit(ShowAdminTableStateLoading());
    FirebaseFirestore.instance.collection('Tables').orderBy('ReserveDate', descending: true).get().then((value){
      emit(ShowAdminTableStateSuccess());
      print('$value');
      for(var doc in value.docs ) {
        adminTables.add(doc.data());
      }
      for(var doc in value.docs ) {
        adminTablesId.add(doc.id);
      }
      print('========$adminTables');
      print('========$adminTablesId');
    }).catchError((e){
      emit(ShowAdminTableStateError(e));
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

  editTableCancel(documentId,index)async{
    emit(ShowAdminTableStateLoading());
    return await FirebaseFirestore.instance.collection('Orders')
        .doc(documentId[index].toString())
        .update({
      'canCancel':'false',
    }).then((value) {
      emit(ShowAdminTableStateSuccess());
    }).catchError((e){
      emit(ShowAdminTableStateError(e));
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
          "body": "The Restaurant Accept Your Table Reservation",
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
      emit(NotificationsStatSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(NotificationsStateError(e.toString()));
    });
  }
  //
  // sendFinish({token})async{
  //   http.post(
  //     Uri.https('fcm.googleapis.com', 'fcm/send'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization':
  //       'key=AAAA1k17ojI:APA91bH7Nkq3gRjWJNn-Ix48rBF9O9vKi-Ev0yb0VCddugXqbQXcKaOsq5yN8mxL2nsB1XtrHQdTAN15KCZ3TLuzRoNj1kOemxhFDkadpcznd3lLx36ZhWc8mwwVLolwj29Q_RI_j17D'
  //     },
  //     body: jsonEncode({
  //       "to": "$token",
  //       "collapse_key": "type_a",
  //       "notification": {
  //         "body": "Your Order Finish And Delivery Man On His Way",
  //         "title": "Message From Tasty-Restaurant",
  //       },
  //       "data": {
  //         "body": "Body : Data",
  //         "title": "Title : Data",
  //         "image": " "
  //       }
  //     }),
  //   ).then((value) {
  //     print('=======success');
  //     emit(NotificationsStateSuccess());
  //   }).catchError((e) {
  //     print(e.toString());
  //     emit(NotificationsStateError(e.toString()));
  //   });
  // }


}