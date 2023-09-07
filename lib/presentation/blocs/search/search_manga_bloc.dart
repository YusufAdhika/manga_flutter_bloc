import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_manga_bloc/domain/entities/search.dart';
import 'package:read_manga_bloc/domain/usecases/get_manga_detail.dart';
import 'package:read_manga_bloc/domain/usecases/get_search.dart';
import 'package:read_manga_bloc/presentation/blocs/manga/manga_bloc.dart';

part 'search_manga_event.dart';
part 'search_manga_state.dart';

class SearchMangaBloc extends Bloc<SearchMangaEvent, SearchMangaState> {
  final GetSearch getSearch;

  SearchMangaBloc(this.getSearch) : super(SearchMangaEmpty()) {
    on<FetchSearchManga>(
      (event, emit) async {
        emit(SearchMangaLoading());

        final query = event.query;

        final result = await getSearch.execute(query);

        result.fold(
          (l) => emit(SearchMangaError(l.message)),
          (r) => emit(SearchMangaHasData(r)),
        );
      },
    );
  }
}
