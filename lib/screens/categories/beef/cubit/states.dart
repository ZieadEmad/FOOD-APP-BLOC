abstract class BeefStates {}

class BeefStateInitial extends BeefStates {}

class BeefStateLoading extends BeefStates {}

class BeefStateSuccess extends BeefStates {}

class BeefStateError extends BeefStates
{
  final error;

  BeefStateError(this.error);
}