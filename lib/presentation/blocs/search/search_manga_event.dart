part of 'search_manga_bloc.dart';

abstract class SearchMangaEvent extends Equatable {
  const SearchMangaEvent();

  @override
  List<Object?> get props => [];
}

class FetchSearchManga extends SearchMangaEvent {
  final String query;

  const FetchSearchManga(this.query);

  @override
  List<Object?> get props => [query];
}
