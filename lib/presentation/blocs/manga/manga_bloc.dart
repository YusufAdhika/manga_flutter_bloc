import 'package:read_manga_bloc/domain/entities/manga.dart';
import 'package:read_manga_bloc/domain/usecases/get_manga.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'manga_event.dart';
part 'manga_state.dart';

class MangaBloc extends Bloc<MangaEvent, MangaState> {
  final GetListManga _getListManga;
  var currentPageNumber = 1;

  MangaBloc(this._getListManga) : super(MangaEmpty()) {
    on<FetchManga>((event, emit) async {
      emit(MangaLoading());
      final result = await _getListManga.execute(currentPageNumber);

      result.fold(
        (failure) => emit(MangaError(failure.message)),
        (data) => emit(MangaHasData(data)),
      );
    });

    on<FetchNextManga>((event, emit) async {
      currentPageNumber++;
      final result = await _getListManga.execute(currentPageNumber);

      result.fold(
        (failure) => emit(MangaError(failure.message)),
        (data) => emit(MangaHasData(data)),
      );
    });
  }
}
