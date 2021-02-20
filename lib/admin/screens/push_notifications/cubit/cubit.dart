import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/screens/push_notifications/cubit/states.dart';
import 'package:food_project/shared/network/remote/dio_helper.dart';

class NotificationCubit extends Cubit<NotificationsStates> {
  String imageLink = ' ';

  NotificationCubit() : super(NotificationsStateInitial());

  static NotificationCubit get(context) => BlocProvider.of(context);


  sendNotification({image,msgBody})async {
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
        print('${value.toString()}');
        imageLink = '${value.toString()}';
        var model = {
          "to": "/topics/TastyUsers",
          "notification": {
            "title": "You Have Received A Message From Tasty-Restaurant",
            "body": "$msgBody",
            "image": "${value.toString()}",
            "sound": "default",
          },
          "android": {
            "priority": "HIGH",
            "notification": {
              "notification_priority": "PRIORITY_MAX",
              "sound": "default",
              "default_sound": true,
              "default_vibrate_timings": true,
              "default_light_settings": true
            }
          },
          "data": {
            "url": "hhhhh",
            "id": "yyyyyy",
          }
        };
        return await DioHelper.postNotification(
          path: 'fcm/send',
          data: jsonEncode(model),
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





}