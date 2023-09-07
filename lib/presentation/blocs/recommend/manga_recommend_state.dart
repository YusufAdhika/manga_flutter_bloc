part of 'manga_recommend_bloc.dart';

abstract class MangaRecommenState extends Equatable {
  const MangaRecommenState();

  @override
  List<Object?> get props => [];
}

class MangaRecommendEmpty extends MangaRecommenState {}

class MangaRecommendLoading extends MangaRecommenState {}

class MangaRecommendError extends MangaRecommenState {
  final String message;

  const MangaRecommendError(this.message);

  @override
  List<Object?> get props => [message];
}

class MangaRecommendHasData extends MangaRecommenState {
  final List<MangaRecommend> result;

  const MangaRecommendHasData(this.result);

  @override
  List<Object?> get props => [result];
}
