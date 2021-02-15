abstract class DessertsStates {}

class DessertsStateInitial extends DessertsStates {}

class DessertsStateLoading extends DessertsStates {}

class DessertsStateSuccess extends DessertsStates {}

class DessertsStateError extends DessertsStates
{
  final error;

  DessertsStateError(this.error);
}