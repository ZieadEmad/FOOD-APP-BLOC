import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';



class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  String token ;

@override
  void initState() {
    super.initState();
    firebaseCloudMessage();
  }

  void firebaseCloudMessage(){
  firebaseMessaging.getToken().then((value) {
    print('token==========$value');
    token=value.toString();
    setState(() {

    });
  });
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
