
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/sign_up/cubit/states.dart';

class SignUpCubit extends Cubit<SignUpStates>
{
  SignUpCubit() : super(SignUpStateInitial());
  static SignUpCubit get(context) => BlocProvider.of(context);

  register({ email, password})
  async{
    emit(SignUpStateLoading());
    final auth = FirebaseAuth.instance;

    try {

      UserCredential authReslut;
      authReslut = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // FirebaseFirestore.instance.collection('users')
      //     .doc(authReslut.user.uid)
      //     .set({
      //   'email': email,
      //   'password': password,
      // });
      emit(SignUpStateSuccess(authReslut));
      print('${authReslut.user}');
    } on FirebaseAuthException catch (e) {
      String message = "error";
      if (e.code == 'weak-password') {
        message = ('the password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        message = ('the account already exists for that email.');
      }

      emit(SignUpStateError(message.toString()));
    }

    // else if (e.code == 'user-not-found') {
    //   message = ('no user found for that email.');
    // } else if (e.code == 'wrong-password') {
    //   message = ('Wrong password provided for that user.');
    // }

    // DioHelper.postData(
    //   path: 'lms/api/v1/auth/signup-save',
    //   data:
    //   {
    //     'email': '$email',
    //     'password': '$password',
    //   }
    // ).then((value)
    // {
    //   emit(SignUpStateSuccess());
    // }).catchError((e)
    // {
    //   emit(SignUpStateError(e.toString()));
    // });
  }
}
