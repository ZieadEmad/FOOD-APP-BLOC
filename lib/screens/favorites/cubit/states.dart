abstract class FavoritesStates {}

class AddFavoritesStateInitial extends FavoritesStates {}

class AddFavoritesStateLoading extends FavoritesStates {}
class ShowFavoritesStateLoading extends FavoritesStates {}

class AddFavoritesStateSuccess extends FavoritesStates {}
class ShowFavoritesStateSuccess extends FavoritesStates {}

class AddFavoritesStateError extends FavoritesStates
{
  final error;

  AddFavoritesStateError(this.error);
}

class ShowFavoritesStateError extends FavoritesStates
{
  final error;

  ShowFavoritesStateError(this.error);
}