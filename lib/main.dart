import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:read_manga_bloc/common/constants.dart';
import 'package:read_manga_bloc/common/routes.dart';
import 'package:read_manga_bloc/common/utils.dart';
import 'package:read_manga_bloc/domain/entities/manga_detail.dart';
import 'package:read_manga_bloc/presentation/blocs/bookmark/bookmark_manga_bloc.dart';
import 'package:read_manga_bloc/presentation/blocs/detail/manga_detail_bloc.dart';
import 'package:read_manga_bloc/presentation/blocs/manga/manga_bloc.dart';
import 'package:read_manga_bloc/presentation/blocs/read_manga/read_manga_bloc.dart';
import 'package:read_manga_bloc/presentation/blocs/recommend/manga_recommend_bloc.dart';
import 'package:read_manga_bloc/presentation/blocs/search/search_manga_bloc.dart';
import 'package:read_manga_bloc/presentation/home_page.dart';
import 'package:read_manga_bloc/injection.dart' as di;
import 'package:read_manga_bloc/presentation/pages/manga_detail_page.dart';
import 'package:read_manga_bloc/presentation/pages/manga_list_page.dart';
import 'package:read_manga_bloc/presentation/pages/manga_recommended_page.dart';
import 'package:read_manga_bloc/presentation/pages/read_list_manga_page.dart';
import 'package:read_manga_bloc/presentation/pages/read_manga_page.dart';
import 'package:read_manga_bloc/presentation/pages/search_page.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MangaBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MangaDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ReadMangaBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MangaRecommendBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMangaBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<BookmarkMangaBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case listMangaRoute:
              return MaterialPageRoute(
                builder: (_) => const MangaListPage(),
              );
            case listMangaRecommendRoute:
              return MaterialPageRoute(
                builder: (_) => const MangaRecommendedPage(),
              );
            case searchManga:
              return MaterialPageRoute(
                builder: (_) => const SearchMangaPage(),
              );
            case detailMangaRoute:
              final id = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => MangaDetailPage(id: id),
                settings: settings,
              );
            case readListMangaRoute:
              final manga = settings.arguments as MangaDetail;
              return MaterialPageRoute(
                builder: (_) => ReadListMangaPage(manga: manga),
                settings: settings,
              );
            case readMangaRoute:
              final id = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => ReadMangaPage(id: id),
                settings: settings,
              );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
