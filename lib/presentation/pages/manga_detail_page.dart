import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:read_manga_bloc/common/constants.dart';
import 'package:read_manga_bloc/common/routes.dart';
import 'package:read_manga_bloc/common/state_enum.dart';
import 'package:read_manga_bloc/domain/entities/manga_detail.dart';
import 'package:read_manga_bloc/presentation/blocs/detail/manga_detail_bloc.dart';

class MangaDetailPage extends StatefulWidget {
  final String id;
  const MangaDetailPage({super.key, required this.id});

  @override
  State<MangaDetailPage> createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MangaDetailBloc>().add(FetchDetailManga(widget.id));
      context.read<MangaDetailBloc>().add(LoadBookmarkStatusManga(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MangaDetailBloc, MangaDetailState>(
        listener: (context, state) {
          final message = state.bookmarkMessage;
          if (message == MangaDetailBloc.watchlistAddSuccessMessage ||
              message == MangaDetailBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: Text(message),
                );
              },
            );
          }
        },
        listenWhen: (oldState, newState) {
          return oldState.bookmarkMessage != newState.bookmarkMessage &&
              newState.bookmarkMessage != '';
        },
        builder: (_, state) {
          final detailState = state.mangaDetailState;
          if (detailState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (detailState == RequestState.loaded) {
            var manga = state.mangaDetail!;
            var isAddedBookmark = state.isAddedToBookmark;
            return SafeArea(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          backgroundColor: kRichBlack,
                          foregroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          child: CircleAvatar(
                            backgroundColor: isAddedBookmark
                                ? kMikadoYellow
                                : Colors.grey[800],
                            child: IconButton(
                              icon: Icon(
                                isAddedBookmark
                                    ? Icons.bookmark
                                    : Icons.bookmark_add,
                                color: isAddedBookmark
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              onPressed: () async {
                                if (!isAddedBookmark) {
                                  context
                                      .read<MangaDetailBloc>()
                                      .add(AddBookmarkManga(manga));
                                } else {
                                  context
                                      .read<MangaDetailBloc>()
                                      .add(RemoveFromBookmarkManga(manga));
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[600],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: FullScreenWidget(
                                disposeLevel: DisposeLevel.Medium,
                                child: CachedNetworkImage(
                                  fit: BoxFit.contain,
                                  imageUrl: manga.thumb,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          manga.title,
                          style: kHeading6,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Text(
                          "•  ${manga.type}  •  ${manga.status}  •  Author by ${manga.author}  • ",
                          style: kBodyText,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Text(
                          "Genres",
                          style: kHeading6,
                        ),
                        Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          children: List.generate(
                            manga.genreList.length,
                            (index) {
                              var data = manga.genreList[index];
                              return InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 4),
                                      child: Text(
                                        data.genreName,
                                        style: kBodyText,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Text(
                          "Synopsis",
                          style: kHeading6,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Text(
                          manga.synopsis,
                          style: kBodyText,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "List Chapter",
                              style: kHeading6,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  readListMangaRoute,
                                  arguments: manga,
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text('See More'),
                                    Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = manga.chapter[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 9),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Ink(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          readMangaRoute,
                                          arguments: data.chapterEndpoint,
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Text(data.chapterTitle),
                                      ),
                                    ),
                                  )),
                            );
                          },
                          itemCount: manga.chapter.length <= 5
                              ? manga.chapter.length
                              : 5,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
          } else if (detailState == RequestState.error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MangaDetail manga;
  final bool isAddedBookmark;

  const DetailContent(this.manga, this.isAddedBookmark, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundColor: kRichBlack,
                  foregroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: CircleAvatar(
                    backgroundColor:
                        isAddedBookmark ? kMikadoYellow : Colors.grey[800],
                    child: IconButton(
                      icon: Icon(
                        isAddedBookmark ? Icons.bookmark : Icons.bookmark_add,
                        color: isAddedBookmark ? Colors.black : Colors.white,
                      ),
                      onPressed: () async {
                        if (!isAddedBookmark) {
                          context
                              .read<MangaDetailBloc>()
                              .add(AddBookmarkManga(manga));
                        } else {
                          context
                              .read<MangaDetailBloc>()
                              .add(RemoveFromBookmarkManga(manga));
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[600],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: FullScreenWidget(
                        disposeLevel: DisposeLevel.Medium,
                        child: CachedNetworkImage(
                          fit: BoxFit.contain,
                          imageUrl: manga.thumb,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  manga.title,
                  style: kHeading6,
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  "•  ${manga.type}  •  ${manga.status}  •  Author by ${manga.author}  • ",
                  style: kBodyText,
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  "Genres",
                  style: kHeading6,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  children: List.generate(
                    manga.genreList.length,
                    (index) {
                      var data = manga.genreList[index];
                      return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 4),
                              child: Text(
                                data.genreName,
                                style: kBodyText,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  "Synopsis",
                  style: kHeading6,
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  manga.synopsis,
                  style: kBodyText,
                ),
                const SizedBox(
                  height: 9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "List Chapter",
                      style: kHeading6,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          readListMangaRoute,
                          arguments: manga,
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('See More'),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = manga.chapter[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(12)),
                          child: Ink(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  readMangaRoute,
                                  arguments: data.chapterEndpoint,
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(data.chapterTitle),
                              ),
                            ),
                          )),
                    );
                  },
                  itemCount:
                      manga.chapter.length <= 5 ? manga.chapter.length : 5,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
