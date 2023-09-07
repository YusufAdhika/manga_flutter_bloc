part of 'manga_bloc.dart';

abstract class MangaEvent extends Equatable {
  const MangaEvent();

  @override
  List<Object?> get props => [];
}

class FetchManga extends MangaEvent {}

class FetchNextManga extends MangaEvent {}
