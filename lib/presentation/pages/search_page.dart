import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_manga_bloc/common/constants.dart';
import 'package:read_manga_bloc/common/routes.dart';
import 'package:read_manga_bloc/presentation/blocs/search/search_manga_bloc.dart';

class SearchMangaPage extends StatefulWidget {
  const SearchMangaPage({super.key});

  @override
  State<SearchMangaPage> createState() => _SearchMangaPageState();
}

class _SearchMangaPageState extends State<SearchMangaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
        ),
        body: SafeArea(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      onSubmitted: (query) {
                        context.read<SearchMangaBloc>().add(
                              FetchSearchManga(query),
                            );
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search title',
                        contentPadding: EdgeInsets.all(14),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      textInputAction: TextInputAction.search,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Search Result',
                      style: kHeading6,
                    ),
                  ],
                ),
              ),
              BlocBuilder<SearchMangaBloc, SearchMangaState>(
                builder: (_, state) {
                  if (state is SearchMangaLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SearchMangaHasData) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      itemBuilder: (context, index) {
                        final manga = state.result[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                detailMangaRoute,
                                arguments: manga.endpoint,
                              );
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  child: CachedNetworkImage(
                                    imageUrl: manga.thumb.toString(),
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 6,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            manga.updateOn.toString(),
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
                      itemCount: state.result.length,
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ));
  }
}
