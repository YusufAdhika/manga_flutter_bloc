// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
// import 'package:read_manga_bloc/data/data_sources/db/database_helper.dart';
// import 'package:read_manga_bloc/data/data_sources/manga_local_data_source.dart';
// import 'package:read_manga_bloc/data/repositories/manga_repository_impl.dart';
// import 'package:read_manga_bloc/data/data_sources/manga_remote_data_source.dart';
// import 'package:read_manga_bloc/domain/repositories/manga_repository.dart';
// import 'package:read_manga_bloc/domain/usecases/get_bookmark_manga.dart';
// import 'package:read_manga_bloc/domain/usecases/get_bookmark_status.dart';
// import 'package:read_manga_bloc/domain/usecases/get_manga.dart';
// import 'package:read_manga_bloc/domain/usecases/get_manga_detail.dart';
// import 'package:read_manga_bloc/domain/usecases/get_manga_recommended.dart';
// import 'package:read_manga_bloc/domain/usecases/get_read_manga.dart';
// import 'package:read_manga_bloc/domain/usecases/get_search.dart';
// import 'package:read_manga_bloc/domain/usecases/remove_bookmark.dart';
// import 'package:read_manga_bloc/domain/usecases/save_bookmark.dart';
// import 'package:read_manga_bloc/presentation/blocs/read_manga/read_manga_notifier.dart';
// import 'package:read_manga_bloc/presentation/blocs/bookmark/bookmark_manga_notifier.dart';
// import 'package:read_manga_bloc/presentation/blocs/detail/manga_detail_notifier.dart';
// import 'package:read_manga_bloc/presentation/blocs/manga/manga_list_notifier.dart';
// import 'package:read_manga_bloc/presentation/blocs/recommend/manga_list_recommended_nofier.dart';
// import 'package:read_manga_bloc/presentation/blocs/search/search_notifier.dart';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:read_manga_bloc/data/data_sources/db/database_helper.dart';
import 'package:read_manga_bloc/data/data_sources/manga_local_data_source.dart';
import 'package:read_manga_bloc/data/data_sources/manga_remote_data_source.dart';
import 'package:read_manga_bloc/data/repositories/manga_repository_impl.dart';
import 'package:read_manga_bloc/domain/repositories/manga_repository.dart';
import 'package:read_manga_bloc/domain/usecases/get_manga.dart';
import 'package:read_manga_bloc/domain/usecases/get_manga_detail.dart';
import 'package:read_manga_bloc/domain/usecases/get_manga_recommended.dart';
import 'package:read_manga_bloc/domain/usecases/get_read_manga.dart';
import 'package:read_manga_bloc/presentation/blocs/detail/manga_detail_bloc.dart';
import 'package:read_manga_bloc/presentation/blocs/manga/manga_bloc.dart';
import 'package:read_manga_bloc/presentation/blocs/read_manga/read_manga_bloc.dart';
import 'package:read_manga_bloc/presentation/blocs/recommend/manga_recommend_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => MangaBloc(locator()));
  locator.registerFactory(() => MangaRecommendBloc(locator()));
  locator.registerFactory(() => MangaDetailBloc(locator()));
  locator.registerFactory(() => ReadMangaBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetListManga(locator()));
  locator.registerLazySingleton(() => GetMangaRecommend(locator()));
  locator.registerLazySingleton(() => GetMangaDetail(locator()));
  locator.registerLazySingleton(() => GetReadManga(locator()));

  // repository
  locator.registerLazySingleton<MangaRepository>(
    () => MangaRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MangaRemoteDataSource>(
      () => MangaRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MangaLocalDataSource>(
      () => MangaLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
