import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/home_screen.dart';
import 'package:food_project/admin/screens/push_notifications/cubit/cubit.dart';
import 'package:food_project/admin/screens/push_notifications/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:image_picker/image_picker.dart';

class PushNotificationsScreen extends StatefulWidget {

  @override
  _PushNotificationsScreenState createState() => _PushNotificationsScreenState();
}

class _PushNotificationsScreenState extends State<PushNotificationsScreen> {

  var massageController = TextEditingController();

  File image ;

  String imageLink = '';

  final picker = ImagePicker();

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        imageLink = '${pickedFile.path}';
      } else {
        showToast(text: 'No image selected.', error: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notifications'),
        actions: [
          SizedBox(width: 10,),
          InkWell(
            onTap: (){navigateAndFinish(context, AdminHomeScreen());},
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home,color: Colors.white,),
                  Text('HOME'),
                ],
              ),
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: BlocProvider(
        create: (context)=> NotificationCubit(),
        child: BlocConsumer<NotificationCubit,NotificationsStates>(
          listener: (context,state){
            if (state is NotificationsStateLoading) {
              print('NotificationsStateLoading');
              return buildProgress(
                  context: context,
                  text: "please Wait until Sending an Notification.. "
              );
            }
            if (state is NotificationsStateSuccess) {
              print('NotificationsStateSuccess');

            }
            if (state is NotificationsStateError) {
              print('NotificationsStateError');
              Navigator.pop(context);
              return buildProgress(
                context: context,
                text: "${state.error.toString()}",
                error: true ,
              );
            }
          },
          builder: (context,state){
            String finalLink = NotificationCubit.get(context).imageLink;
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Center(
                        child:TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter Your Message',
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          maxLines: 8,
                          controller: massageController ,
                        ),
                      ),
                      SizedBox(height: 50,),
                      imageLink != ''
                          ? CircleAvatar(
                        radius: 80,
                        child: CircleAvatar(
                          child: ClipOval(
                            child: Image.file(
                              File(imageLink),
                              fit: BoxFit.cover,
                            ),
                          ),
                          radius: 100,
                        ),
                      )
                          : defaultButton(
                        function: (){getImage();},
                        text: '+ Add Photo',
                        width: 150 ,
                      ),
                      SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16,),
                        child: defaultButton(
                            function: (){

                              String massage = massageController.text;
                              if(massage.isEmpty&& imageLink.isEmpty){
                                showToast(text: 'Please Enter Full Data And Choose photo' , error: true);
                              }
                              else {
                                NotificationCubit.get(context).sendNotification(
                                  image: image,
                                  msgBody: massage,
                                );
                              }

                           },
                            text: 'Send Notification',
                            radius: 16
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
