abstract class AllMealsStates {}

class AllMealsStateInitial extends AllMealsStates {}

class AllMealsStateLoading extends AllMealsStates {}

class AllMealsStateSuccess extends AllMealsStates {}

class AllMealsStateError extends AllMealsStates
{
  final error;

  AllMealsStateError(this.error);
}

class EditMealsStateLoading extends AllMealsStates {}

class EditMealsStateSuccess extends AllMealsStates {}

class EditMealsStateError extends AllMealsStates
{
  final error;

  EditMealsStateError(this.error);
}
