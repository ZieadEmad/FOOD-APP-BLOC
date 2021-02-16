abstract class CartStates {}

class CartStateInitial extends CartStates {}

class AddCartStateLoading extends CartStates {}
class ShowCartStateLoading extends CartStates {}

class AddCartStateSuccess extends CartStates {}
class ShowCartStateSuccess extends CartStates {}

class AddCartStateError extends CartStates
{
  final error;

  AddCartStateError(this.error);
}

class ShowCartStateError extends CartStates
{
  final error;

  ShowCartStateError(this.error);
}