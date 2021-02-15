abstract class AppetizersStates {}

class AppetizersStateInitial extends AppetizersStates {}

class AppetizersStateLoading extends AppetizersStates {}

class AppetizersStateSuccess extends AppetizersStates {}

class AppetizersStateError extends AppetizersStates
{
  final error;

  AppetizersStateError(this.error);
}