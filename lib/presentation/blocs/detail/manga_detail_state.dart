part of 'manga_detail_bloc.dart';

abstract class MangaDetailState extends Equatable {
  const MangaDetailState();

  @override
  List<Object?> get props => [];
}

class MangaDetailEmpty extends MangaDetailState {}

class MangaDetailError extends MangaDetailState {
  final String message;

  const MangaDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class MangaDetailLoading extends MangaDetailState {}

class MangaDetailHasData extends MangaDetailState {
  final MangaDetail result;

  const MangaDetailHasData(this.result);

  @override
  List<Object?> get props => [result];
}
