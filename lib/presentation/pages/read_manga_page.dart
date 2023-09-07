import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_manga_bloc/common/constants.dart';
import 'package:read_manga_bloc/presentation/blocs/read_manga/read_manga_bloc.dart';

class ReadMangaPage extends StatefulWidget {
  const ReadMangaPage({super.key, required this.id});

  final String id;

  @override
  State<ReadMangaPage> createState() => _ReadMangaPageState();
}

class _ReadMangaPageState extends State<ReadMangaPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<ReadMangaBloc>().add(FetchReadManga(widget.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  BlocBuilder<ReadMangaBloc, ReadMangaState>(
                    builder: (_, state) {
                      if (state is ReadMangaLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ReadMangaHasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var manga = state.result[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 18),
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl: manga.chapterImageLink,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(),
                                ),
                              ),
                            );
                          },
                          itemCount: state.result.length,
                        );
                      } else {
                        return const Text('Failed');
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: kRichBlack,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
