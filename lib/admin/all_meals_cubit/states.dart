abstract class AllMealsStates {}

class AllMealsStateInitial extends AllMealsStates {}

class AllMealsStateLoading extends AllMealsStates {}

class AllMealsStateSuccess extends AllMealsStates {}

class AllMealsStateError extends AllMealsStates
{
  final error;

  AllMealsStateError(this.error);
}