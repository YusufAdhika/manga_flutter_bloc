part of 'bookmark_manga_bloc.dart';

abstract class BookmarkMangaState extends Equatable {
  const BookmarkMangaState();

  @override
  List<Object?> get props => [];
}

class BookmarkMangaEmpty extends BookmarkMangaState {}

class BookmarkMangaError extends BookmarkMangaState {
  final String message;

  const BookmarkMangaError(this.message);

  @override
  List<Object?> get props => [message];
}

class BookmarkMangaLoading extends BookmarkMangaState {}

class BookmarkMangaHasData extends BookmarkMangaState {
  final List<Manga> result;

  const BookmarkMangaHasData(this.result);

  @override
  List<Object?> get props => [result];
}
