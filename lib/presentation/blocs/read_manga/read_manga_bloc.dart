import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_manga_bloc/domain/entities/read_manga.dart';
import 'package:read_manga_bloc/domain/usecases/get_read_manga.dart';

part 'read_manga_event.dart';
part 'read_manga_state.dart';

class ReadMangaBloc extends Bloc<ReadMangaEvent, ReadMangaState> {
  final GetReadManga readManga;

  ReadMangaBloc(this.readManga) : super(ReadMangaEmpty()) {
    on<FetchReadManga>((event, emit) async {
      final id = event.id;
      emit(ReadMangaLoading());

      final result = await readManga.execute(id);

      result.fold(
        (failure) => emit(ReadMangaError(failure.message)),
        (data) => emit(ReadMangaHasData(data)),
      );
    });
  }
}
