import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_manga_bloc/domain/entities/manga_detail.dart';
import 'package:read_manga_bloc/domain/usecases/get_manga_detail.dart';

part 'manga_detail_state.dart';
part 'manga_detail_event.dart';

class MangaDetailBloc extends Bloc<MangaDetailEvent, MangaDetailState> {
  final GetMangaDetail _mangaDetail;

  MangaDetailBloc(this._mangaDetail) : super(MangaDetailEmpty()) {
    on<FetchDetailManga>(
      (event, emit) async {
        emit(MangaDetailLoading());

        final id = event.id;

        final result = await _mangaDetail.execute(id);

        result.fold(
          (failure) => emit(MangaDetailError(failure.message)),
          (data) => emit(MangaDetailHasData(data)),
        );
      },
    );
  }
}
