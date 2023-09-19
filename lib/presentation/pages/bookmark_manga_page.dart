import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_manga_bloc/common/constants.dart';
import 'package:read_manga_bloc/common/routes.dart';
import 'package:read_manga_bloc/common/utils.dart';
import 'package:read_manga_bloc/presentation/blocs/bookmark/bookmark_manga_bloc.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<BookmarkMangaBloc>().add(FetchBookmarkManga()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<BookmarkMangaBloc>().add(FetchBookmarkManga());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manga Bookmark")),
      body: BlocBuilder<BookmarkMangaBloc, BookmarkMangaState>(
        builder: (context, state) {
          if (state is BookmarkMangaLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BookmarkMangaHasData) {
            return CustomScrollView(
              slivers: [
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final manga = state.result[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            detailMangaRoute,
                            arguments: manga.endpoint,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: CachedNetworkImage(
                                height: 200,
                                imageUrl: manga.thumb.toString(),
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                "manga.title",
                                style: kSubtitle,
                                textAlign:
                                    TextAlign.center, // Center-align the text
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    childCount: state.result.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 0.7,
                  ),
                ),
              ],
            );
          } else {
            return const Text('Failed');
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
