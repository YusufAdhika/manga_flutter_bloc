import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_manga_bloc/domain/entities/manga_recommend.dart';
import 'package:read_manga_bloc/domain/usecases/get_manga_recommended.dart';

part 'manga_recommend_state.dart';
part 'manga_recommend_event.dart';

class MangaRecommendBloc extends Bloc<MangaRecommenEvent, MangaRecommenState> {
  final GetMangaRecommend mangaRecommend;

  MangaRecommendBloc(this.mangaRecommend) : super(MangaRecommendEmpty()) {
    on<FetchMangaRecommend>((event, emit) async {
      emit(MangaRecommendLoading());

      var result = await mangaRecommend.execute();

      result.fold(
        (failure) => emit(MangaRecommendError(failure.message)),
        (result) => emit(MangaRecommendHasData(result)),
      );
    });
  }
}
