import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_manga_bloc/common/constants.dart';
import 'package:read_manga_bloc/common/routes.dart';
import 'package:read_manga_bloc/domain/entities/manga.dart';
import 'package:read_manga_bloc/presentation/blocs/manga/manga_bloc.dart';

class MangaListPage extends StatefulWidget {
  const MangaListPage({super.key});

  @override
  State<MangaListPage> createState() => _MangaListPageState();
}

class _MangaListPageState extends State<MangaListPage> {
  final scrollController = ScrollController();
  final list = List<Manga>.empty(growable: true);
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    Future.microtask(() => context.read<MangaBloc>().add(FetchManga()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Read Manga'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, searchManga);
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            list == [];
            await Future.microtask(
                () => context.read<MangaBloc>().add(FetchManga()));
          },
          child: BlocBuilder<MangaBloc, MangaState>(
            builder: (_, state) {
              if (state is MangaLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MangaHasData) {
                list.addAll(state.result);
                return ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                  ),
                  itemBuilder: (context, index) {
                    final manga = list[index];
                    if (index == list.length - 1) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: InkWell(
                        onTap: () {
                          var filter = manga.endpoint.replaceAll("/", "");
                          Navigator.pushNamed(
                            context,
                            detailMangaRoute,
                            arguments: filter,
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: CachedNetworkImage(
                                imageUrl: manga.thumb.toString(),
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    AspectRatio(
                                  aspectRatio: 1 / 0.5,
                                  child: Image.asset(
                                    "assets/placeholder.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 6,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    manga.title.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: kSubtitle,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        manga.type.toString(),
                                        maxLines: 1,
                                        style: kBodyText,
                                      ),
                                      Text(
                                        manga.uploadOn.toString(),
                                        maxLines: 1,
                                        style: kBodyText,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: list.length,
                );
              } else {
                return const Text('Failed');
              }
            },
          ),
        ));
  }

  void _refreshList() async {
    list.clear();
    Future.microtask(() => context.read<MangaBloc>().add(FetchNextManga()));
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      Future.microtask(() => context.read<MangaBloc>().add(FetchNextManga()));
    }
  }
}
