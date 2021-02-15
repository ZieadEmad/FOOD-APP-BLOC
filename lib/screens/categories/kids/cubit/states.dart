abstract class KidsMealsStates {}

class KidsMealsStateInitial extends KidsMealsStates {}

class KidsMealsStateLoading extends KidsMealsStates {}

class KidsMealsStateSuccess extends KidsMealsStates {}

class KidsMealsStateError extends KidsMealsStates
{
  final error;

  KidsMealsStateError(this.error);
}