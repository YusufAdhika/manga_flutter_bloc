import 'package:flutter/material.dart';
import 'package:read_manga_bloc/common/constants.dart';
import 'package:read_manga_bloc/domain/entities/manga_detail.dart';

import '../../common/routes.dart';

class ReadListMangaPage extends StatefulWidget {
  const ReadListMangaPage({
    super.key,
    required this.manga,
  });

  final MangaDetail manga;

  @override
  State<ReadListMangaPage> createState() => _ReadListMangaPageState();
}

class _ReadListMangaPageState extends State<ReadListMangaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
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
                  SizedBox(
                    width: 300,
                    child: Text(
                      widget.manga.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                ),
                itemBuilder: (context, index) {
                  var data = widget.manga.chapter[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18),
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
                itemCount: widget.manga.chapter.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}
