part of 'manga_bloc.dart';

abstract class MangaState extends Equatable {
  const MangaState();

  @override
  List<Object?> get props => [];
}

class MangaEmpty extends MangaState {}

class MangaLoading extends MangaState {}

class MangaError extends MangaState {
  final String message;

  const MangaError(this.message);

  @override
  List<Object?> get props => [message];
}

class MangaHasData extends MangaState {
  final List<Manga> result;

  const MangaHasData(this.result);

  @override
  List<Object?> get props => [result];
}
