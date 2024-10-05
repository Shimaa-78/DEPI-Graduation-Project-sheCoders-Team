part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}
final class FavouriteLoading extends FavouriteState {}
final class FavouriteSuccess extends FavouriteState {}
final class FavouriteError extends FavouriteState {
  String ?message;
  FavouriteError(this.message);
}


class FavouriteRemovedLoading extends FavouriteState {
  int? id;
  FavouriteRemovedLoading(this.id);

}
class FavouriteRemovedError extends FavouriteState {
  String? message;
  FavouriteRemovedError(this.message);
}
class FavouriteRemovedSuccess extends FavouriteState {

}

class FavouriteAddLoading extends FavouriteState {


}
class FavouriteAddError extends FavouriteState {
  String? message;
  FavouriteAddError(this.message);
}
class FavouriteAddSuccess extends FavouriteState {

}/////////////////////