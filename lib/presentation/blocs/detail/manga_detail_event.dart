part of 'manga_detail_bloc.dart';

abstract class MangaDetailEvent extends Equatable {
  const MangaDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchDetailManga extends MangaDetailEvent {
  final String id;

  const FetchDetailManga(this.id);

  @override
  List<Object?> get props => [id];
}

class AddBookmarkManga extends MangaDetailEvent {
  final MangaDetail mangaDetail;

  const AddBookmarkManga(this.mangaDetail);

  @override
  List<Object?> get props => [mangaDetail];
}

class RemoveFromBookmarkManga extends MangaDetailEvent {
  final MangaDetail mangaDetail;

  const RemoveFromBookmarkManga(this.mangaDetail);

  @override
  List<Object?> get props => [mangaDetail];
}

class LoadBookmarkStatusManga extends MangaDetailEvent {
  final String endpoint;

  const LoadBookmarkStatusManga(this.endpoint);

  @override
  List<Object?> get props => [endpoint];
}
