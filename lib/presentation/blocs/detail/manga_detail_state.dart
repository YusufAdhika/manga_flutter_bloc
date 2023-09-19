part of 'manga_detail_bloc.dart';

class MangaDetailState extends Equatable {
  final MangaDetail? mangaDetail;
  final RequestState mangaDetailState;
  final String message;
  final String bookmarkMessage;
  final bool isAddedToBookmark;

  const MangaDetailState({
    required this.mangaDetail,
    required this.mangaDetailState,
    required this.message,
    required this.bookmarkMessage,
    required this.isAddedToBookmark,
  });

  @override
  List<Object?> get props => [
        mangaDetail,
        mangaDetailState,
        message,
        bookmarkMessage,
        isAddedToBookmark,
      ];

  MangaDetailState copyWith({
    MangaDetail? mangaDetail,
    RequestState? mangaDetailState,
    String? message,
    String? bookmarkMessage,
    bool? isAddedToBookmark,
  }) {
    return MangaDetailState(
      mangaDetail: mangaDetail ?? this.mangaDetail,
      mangaDetailState: mangaDetailState ?? this.mangaDetailState,
      message: message ?? this.message,
      bookmarkMessage: bookmarkMessage ?? this.bookmarkMessage,
      isAddedToBookmark: isAddedToBookmark ?? this.isAddedToBookmark,
    );
  }

  factory MangaDetailState.initial() {
    return const MangaDetailState(
      mangaDetail: null,
      mangaDetailState: RequestState.empty,
      message: '',
      bookmarkMessage: '',
      isAddedToBookmark: false,
    );
  }
}
