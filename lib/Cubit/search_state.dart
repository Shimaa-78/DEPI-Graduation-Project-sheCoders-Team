part of 'search_cubit.dart';


@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}
final class SearchsLoading extends  SearchState {}

final class  SearchSucess extends  SearchState {
  final List<Product> products;
  SearchSucess({required this.products});
}

final class SearchError extends  SearchState {
  final String message;
  SearchError({required this.message});
}/////////////////////
/////////////////////
/////////////////////