abstract class ShowAdminOrderStates {}

class ShowAdminOrderStateInitial extends ShowAdminOrderStates {}


class ShowAdminOrderStateLoading extends ShowAdminOrderStates {}


class ShowAdminOrderStateSuccess extends ShowAdminOrderStates {}


class ShowAdminOrderStateError extends ShowAdminOrderStates
{
  final error;

  ShowAdminOrderStateError(this.error);
}