abstract class UpdateProfileStates {}

class UpdateProfileStateInitial extends UpdateProfileStates {}

class AddProfilePhotoStateLoading extends UpdateProfileStates {}

class AddProfilePhotoStateSuccess extends UpdateProfileStates {}

class AddProfilePhotoStateError extends UpdateProfileStates
{
  final error;

  AddProfilePhotoStateError(this.error);
}


class UpdateProfilePhotoStateLoading extends UpdateProfileStates {}

class UpdateProfilePhotoStateSuccess extends UpdateProfileStates {}

class UpdateProfilePhotoStateError extends UpdateProfileStates {
  final error;

  UpdateProfilePhotoStateError(this.error);
}


class UpdateProfileNameStateLoading extends UpdateProfileStates {}

class UpdateProfileNameStateSuccess extends UpdateProfileStates {}

class UpdateProfileNameStateError extends UpdateProfileStates {
  final error;

  UpdateProfileNameStateError(this.error);
}