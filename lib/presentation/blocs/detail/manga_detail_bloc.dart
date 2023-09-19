import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_manga_bloc/common/state_enum.dart';
import 'package:read_manga_bloc/domain/entities/manga_detail.dart';
import 'package:read_manga_bloc/domain/usecases/get_bookmark_status.dart';
import 'package:read_manga_bloc/domain/usecases/get_manga_detail.dart';
import 'package:read_manga_bloc/domain/usecases/remove_bookmark.dart';
import 'package:read_manga_bloc/domain/usecases/save_bookmark.dart';

part 'manga_detail_state.dart';
part 'manga_detail_event.dart';

class MangaDetailBloc extends Bloc<MangaDetailEvent, MangaDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMangaDetail mangaDetail;
  final GetBookmarkListStatus getBookmarkListStatus;
  final RemoveBookmark removeBookmark;
  final SaveBookmark saveBookmark;

  MangaDetailBloc({
    required this.mangaDetail,
    required this.getBookmarkListStatus,
    required this.removeBookmark,
    required this.saveBookmark,
  }) : super(MangaDetailState.initial()) {
    on<FetchDetailManga>((event, emit) async {
      emit(state.copyWith(mangaDetailState: RequestState.loading));

      final id = event.id;

      final result = await mangaDetail.execute(id);

      result.fold(
        (failure) => emit(state.copyWith(
            mangaDetailState: RequestState.error, message: failure.message)),
        (data) => emit(state.copyWith(
            mangaDetailState: RequestState.loaded, mangaDetail: data)),
      );
    });

    on<AddBookmarkManga>((event, emit) async {
      final movieDetail = event.mangaDetail;
      final result = await saveBookmark.execute(movieDetail);

      result.fold(
        (failure) => emit(state.copyWith(bookmarkMessage: failure.message)),
        (successMessage) =>
            emit(state.copyWith(bookmarkMessage: successMessage)),
      );

      add(LoadBookmarkStatusManga(movieDetail.mangaEndpoint));
    });

    on<RemoveFromBookmarkManga>((event, emit) async {
      final movieDetail = event.mangaDetail;
      final result = await removeBookmark.execute(movieDetail);

      result.fold(
        (failure) => emit(state.copyWith(bookmarkMessage: failure.message)),
        (successMessage) =>
            emit(state.copyWith(bookmarkMessage: successMessage)),
      );

      add(LoadBookmarkStatusManga(movieDetail.mangaEndpoint));
    });

    on<LoadBookmarkStatusManga>((event, emit) async {
      final status = await getBookmarkListStatus.execute(event.endpoint);
      emit(state.copyWith(isAddedToBookmark: status));
    });
  }
}
