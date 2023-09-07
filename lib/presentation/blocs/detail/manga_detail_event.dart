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
