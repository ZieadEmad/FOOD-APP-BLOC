import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpStates {}

class SignUpStateInitial extends SignUpStates {}

class SignUpStateLoading extends SignUpStates {}

class SignUpStateSuccess extends SignUpStates {
  UserCredential authRuslut ;
  SignUpStateSuccess(this.authRuslut);
}

class SignUpStateError extends SignUpStates
{
  final error;

  SignUpStateError(this.error);
}