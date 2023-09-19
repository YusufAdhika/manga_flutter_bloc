import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_manga_bloc/domain/entities/manga.dart';
import 'package:read_manga_bloc/domain/usecases/get_bookmark_manga.dart';

part 'bookmark_manga_event.dart';
part 'bookmark_manga_state.dart';

class BookmarkMangaBloc extends Bloc<BookmarkMangaEvent, BookmarkMangaState> {
  final GetBookmarklistManga getBookmarklistManga;

  BookmarkMangaBloc(this.getBookmarklistManga) : super(BookmarkMangaEmpty()) {
    on<FetchBookmarkManga>((event, emit) async {
      emit(BookmarkMangaLoading());

      final result = await getBookmarklistManga.execute();

      result.fold(
        (failure) => emit(BookmarkMangaError(failure.message)),
        (data) => emit(BookmarkMangaHasData(data)),
      );
    });
  }
}
