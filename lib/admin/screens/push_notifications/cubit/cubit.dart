import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/screens/push_notifications/cubit/states.dart';

import 'package:http/http.dart' as http;
class NotificationCubit extends Cubit<NotificationsStates> {
  String imageLink = ' ';

  NotificationCubit() : super(NotificationsStateInitial());

  static NotificationCubit get(context) => BlocProvider.of(context);


  sendNotification2({image,msgBody})async {
    emit(NotificationsStateLoading());
    return await FirebaseStorage.instance
        .ref()
        .child('photos/${Uri
        .file(image.path)
        .pathSegments
        .last}')
        .putFile(image)
        .then((value) {
      value.ref.getDownloadURL().then((value) async {
        // print('${value.toString()}');
        imageLink = '${value.toString()}';
        http.post(
          Uri.https('fcm.googleapis.com', 'fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
            'key=AAAA1k17ojI:APA91bH7Nkq3gRjWJNn-Ix48rBF9O9vKi-Ev0yb0VCddugXqbQXcKaOsq5yN8mxL2nsB1XtrHQdTAN15KCZ3TLuzRoNj1kOemxhFDkadpcznd3lLx36ZhWc8mwwVLolwj29Q_RI_j17D'
          },
          body: jsonEncode({
            "to": "/topics/TastyUsers",
            "collapse_key": "type_a",
            "notification": {
              "body": "$msgBody",
              "title": "Message From Tasty-Restaurant",
              "image":
              "${value.toString()}"
            },
            "data": {
              "body": "Body : Data",
              "title": "Title : Data",
              "image":
              "https://metaltechalley.com/wp-content/uploads/2017/09/data.jpg"
            }
          }),
        ).then((value) {
          print('=======success');
          emit(NotificationsStateSuccess());
        }).catchError((e) {
          print(e.toString());
          emit(NotificationsStateError(e.toString()));
        });
      });
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

  sendAdmin()async{
    http.post(
      Uri.https('fcm.googleapis.com', 'fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
        'key=AAAA1k17ojI:APA91bH7Nkq3gRjWJNn-Ix48rBF9O9vKi-Ev0yb0VCddugXqbQXcKaOsq5yN8mxL2nsB1XtrHQdTAN15KCZ3TLuzRoNj1kOemxhFDkadpcznd3lLx36ZhWc8mwwVLolwj29Q_RI_j17D'
      },
      body: jsonEncode({
        "to": "/topics/TastyAdmin",
        "collapse_key": "type_a",
        "notification": {
          "body": "You Have A New Order",
          "title": "Message From Customer",
        },
        "data": {
          "body": "You Have a New Order",
          "title": "New Order",
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

  sendAdminTables()async{
    http.post(
      Uri.https('fcm.googleapis.com', 'fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
        'key=AAAA1k17ojI:APA91bH7Nkq3gRjWJNn-Ix48rBF9O9vKi-Ev0yb0VCddugXqbQXcKaOsq5yN8mxL2nsB1XtrHQdTAN15KCZ3TLuzRoNj1kOemxhFDkadpcznd3lLx36ZhWc8mwwVLolwj29Q_RI_j17D'
      },
      body: jsonEncode({
        "to": "/topics/TastyAdmin",
        "collapse_key": "type_a",
        "notification": {
          "body": "You Have A New Table Reservation",
          "title": "Message From Customer",
        },
        "data": {
          "body": "You Have A New Table Reservation",
          "title": "New Order",
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




