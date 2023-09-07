part of 'search_manga_bloc.dart';

abstract class SearchMangaState extends Equatable {
  const SearchMangaState();

  @override
  List<Object?> get props => [];
}

class SearchMangaEmpty extends SearchMangaState {}

class SearchMangaError extends SearchMangaState {
  final String message;

  const SearchMangaError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchMangaLoading extends SearchMangaState {}

class SearchMangaHasData extends SearchMangaState {
  final List<Search> result;

  const SearchMangaHasData(this.result);

  @override
  List<Object?> get props => [result];
}
