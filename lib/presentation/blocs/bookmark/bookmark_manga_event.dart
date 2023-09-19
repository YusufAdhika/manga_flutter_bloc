part of 'bookmark_manga_bloc.dart';

abstract class BookmarkMangaEvent extends Equatable {
  const BookmarkMangaEvent();

  @override
  List<Object?> get props => [];
}

class FetchBookmarkManga extends BookmarkMangaEvent {}
