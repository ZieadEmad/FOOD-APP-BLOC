import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/profile/update_profile/cubit/cubit.dart';
import 'package:food_project/screens/profile/update_profile/cubit/state.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:image_picker/image_picker.dart';


class UpdateProfileScreen extends StatefulWidget {

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  File image ;

  String imageLink = '';

  final picker = ImagePicker();

  getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
        image = File(pickedFile.path);
        imageLink = '${pickedFile.path}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Your Profile'),
        actions: [
          SizedBox(width: 10,),
          InkWell(
            onTap: (){navigateAndFinish(context, LayoutScreen());},
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context)=> UpdateProfileCubit() ,
          child: BlocConsumer<UpdateProfileCubit,UpdateProfileStates>(
            listener: (context,state){},
            builder: (context,state){
              String imageUrlFinal = UpdateProfileCubit.get(context).imagelink;
              return ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      defaultTextBox(
                        title: "New Name",
                        hint: 'Enter your Name With Out Space',
                        controller: nameController,
                        type: TextInputType.text,
                      ),
                      SizedBox(height: 100,),
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
                        text: '+ Edit Your Photo',
                        width: 250 ,
                      ),
                      SizedBox(height: 150,),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Please Check Your Data Before Saving',style: TextStyle(fontSize: 10),),
                                  SizedBox(width: 5,),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30,right: 30,top: 15),
                              child: defaultButton(
                                function: () {

                                  if(imageUrlFinal.length != 0 && image !=null){
                                    UpdateProfileCubit.get(context).updatePhoto(image:image);
                                    showToast(text: 'Your Data Saved', error:  false );
                                    navigateAndFinish(context, LayoutScreen());

                                  }

                                  String name = nameController.text;
                                  if(name.isNotEmpty){
                                    UpdateProfileCubit.get(context).updateName(name.toString());
                                    showToast(text: 'Your Data Saved', error:  false );
                                    navigateAndFinish(context, LayoutScreen());
                                  }
                                },
                                text: 'Save And Finish',
                                background: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
