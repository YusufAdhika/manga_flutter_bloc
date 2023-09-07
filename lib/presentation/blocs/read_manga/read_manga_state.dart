part of 'read_manga_bloc.dart';

abstract class ReadMangaState extends Equatable {
  const ReadMangaState();

  @override
  List<Object?> get props => [];
}

class ReadMangaEmpty extends ReadMangaState {}

class ReadMangaLoading extends ReadMangaState {}

class ReadMangaError extends ReadMangaState {
  final String message;

  const ReadMangaError(this.message);

  @override
  List<Object?> get props => [];
}

class ReadMangaHasData extends ReadMangaState {
  final List<ReadManga> result;

  const ReadMangaHasData(this.result);

  @override
  List<Object?> get props => [result];
}
