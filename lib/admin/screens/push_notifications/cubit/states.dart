abstract class NotificationsStates {}

class NotificationsStateInitial extends NotificationsStates {}

class NotificationsStateLoading extends NotificationsStates {}

class NotificationsStateSuccess extends NotificationsStates {}

class NotificationsStateError extends NotificationsStates {
  final String error;

  NotificationsStateError(this.error);
}