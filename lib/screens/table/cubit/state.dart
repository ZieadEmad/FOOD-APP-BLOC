abstract class TableStates {}


class TableStateInitial extends TableStates {}

class TimeStateIndex extends TableStates {}




class AddTableStateLoading extends TableStates {}


class AddTableStateSuccess extends TableStates {}


class AddTableStateError extends TableStates
{
  final error;

  AddTableStateError(this.error);
}




class ShowTableStateLoading extends TableStates {}


class ShowTableStateSuccess extends TableStates {}


class ShowTableStateError extends TableStates
{
  final error;

  ShowTableStateError(this.error);
}

