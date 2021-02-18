import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/profile/update_profile/cubit/state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileStates> {
  String imagelink = ' ';
  var auth = FirebaseAuth.instance.currentUser;

  UpdateProfileCubit() : super(UpdateProfileStateInitial());
  static UpdateProfileCubit get(context) => BlocProvider.of(context);

  updatePhoto({File image}) async {
    emit(AddProfilePhotoStateLoading());
    return await FirebaseStorage.instance
        .ref()
        .child('photos/${Uri.file(image.path)
        .pathSegments.last}')
        .putFile(image)
        .then((value){
      value.ref.getDownloadURL().then((value)async{
        if (auth != null) {
          auth.updateProfile(photoURL:'$value').then((value)async{
            emit(UpdateProfilePhotoStateSuccess());
            print('=-=-=-=--=-${auth.photoURL}');
          }).catchError((e){
            emit(UpdateProfilePhotoStateError(e.toString()));
          });
        print('${value.toString()}');
        imagelink = '${value.toString()}' ;
        emit(AddProfilePhotoStateSuccess());
      }}).catchError((e){
        emit(AddProfilePhotoStateError(e.toString()));
      });
    });

  }


  updateName(String name){
    emit(UpdateProfileNameStateLoading());
    if (auth != null) {
      auth.updateProfile(displayName:'$name').then((value) {
        emit(UpdateProfileNameStateSuccess());
      }).catchError((e){
        emit(UpdateProfileNameStateError(e.toString()));
      });
    }
  }
}