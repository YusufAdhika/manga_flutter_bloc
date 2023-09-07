part of 'manga_recommend_bloc.dart';

abstract class MangaRecommenEvent extends Equatable {
  const MangaRecommenEvent();

  @override
  List<Object?> get props => [];
}

class FetchMangaRecommend extends MangaRecommenEvent {}
