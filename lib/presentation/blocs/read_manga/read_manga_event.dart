part of 'read_manga_bloc.dart';

abstract class ReadMangaEvent extends Equatable {
  const ReadMangaEvent();

  @override
  List<Object?> get props => [];
}

class FetchReadManga extends ReadMangaEvent {
  final String id;

  const FetchReadManga(this.id);

  @override
  List<Object?> get props => [id];
}
