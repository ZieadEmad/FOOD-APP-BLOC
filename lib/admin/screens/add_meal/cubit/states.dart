abstract class AddMealStates {}

class AddMealStateInitial extends AddMealStates {}

class AddMealStateLoading extends AddMealStates {}

class AddMealStateSuccess extends AddMealStates {}

class AddMealStateError extends AddMealStates
{
  final error;

  AddMealStateError(this.error);
}