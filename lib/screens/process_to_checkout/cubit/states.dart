abstract class OrderStates {}

class OrderStateInitial extends OrderStates {}

class AddOrderStateLoading extends OrderStates {}


class AddOrderStateSuccess extends OrderStates {}


class AddOrderStateError extends OrderStates
{
  final error;

  AddOrderStateError(this.error);
}

