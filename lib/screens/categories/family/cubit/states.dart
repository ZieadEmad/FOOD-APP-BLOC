abstract class FamilyMealsStates {}

class FamilyMealsStateInitial extends FamilyMealsStates {}

class FamilyMealsStateLoading extends FamilyMealsStates {}

class FamilyMealsStateSuccess extends FamilyMealsStates {}

class FamilyMealsStateError extends FamilyMealsStates
{
  final error;

  FamilyMealsStateError(this.error);
}