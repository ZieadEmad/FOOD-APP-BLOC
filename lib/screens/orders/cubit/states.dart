abstract class ShowOrderStates {}

class ShowOrderStateInitial extends ShowOrderStates {}


class ShowOrderStateLoading extends ShowOrderStates {}


class ShowOrderStateSuccess extends ShowOrderStates {}


class ShowOrderStateError extends ShowOrderStates
{
  final error;

  ShowOrderStateError(this.error);
}