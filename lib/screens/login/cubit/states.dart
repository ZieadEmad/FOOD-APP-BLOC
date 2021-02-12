abstract class LoginStates {}

class LoginStatesInitial extends LoginStates {}

class LoginStatesLoading extends LoginStates {}

class LoginStatesSuccess extends LoginStates {
  final token;

  LoginStatesSuccess(this.token);
}

class LoginStatesError extends LoginStates
{
  final error;

  LoginStatesError(this.error);
}