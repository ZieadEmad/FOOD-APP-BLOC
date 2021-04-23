abstract class ShowAdminTableStates {}

class ShowAdminTableStateInitial extends ShowAdminTableStates {}


class ShowAdminTableStateLoading extends ShowAdminTableStates {}


class ShowAdminTableStateSuccess extends ShowAdminTableStates {}


class ShowAdminTableStateError extends ShowAdminTableStates
{
  final error;

  ShowAdminTableStateError(this.error);
}


class NotificationsStatSuccess extends ShowAdminTableStates {}

class NotificationsStateError extends ShowAdminTableStates {
  final String error;

  NotificationsStateError(this.error);
}