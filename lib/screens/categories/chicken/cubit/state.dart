
abstract class ChickenSandwichStates {}

class ChickenSandwichStateInitial extends ChickenSandwichStates {}

class ChickenSandwichStateLoading extends ChickenSandwichStates {}

class ChickenSandwichStateSuccess extends ChickenSandwichStates {}

class ChickenSandwichStateError extends ChickenSandwichStates
{
  final error;

  ChickenSandwichStateError(this.error);
}