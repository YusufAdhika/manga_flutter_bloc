import 'package:dartz/dartz.dart';
import 'package:read_manga_bloc/common/failure.dart';
import 'package:read_manga_bloc/domain/entities/manga.dart';
import 'package:read_manga_bloc/domain/entities/manga_detail.dart';
import 'package:read_manga_bloc/domain/entities/manga_recommend.dart';
import 'package:read_manga_bloc/domain/entities/read_manga.dart';
import 'package:read_manga_bloc/domain/entities/search.dart';

abstract class MangaRepository {
  Future<Either<Failure, List<Manga>>> getManga(int page);
  Future<Either<Failure, MangaDetail>> getMangaDetail(String id);
  Future<Either<Failure, List<MangaRecommend>>> getMangaRecommend();
  Future<Either<Failure, List<ReadManga>>> getReadManga(String id);
  Future<Either<Failure, List<Search>>> getSearch(String query);
  Future<Either<Failure, String>> saveBookmark(MangaDetail manga);
  Future<Either<Failure, String>> removeBookmark(MangaDetail manga);
  Future<bool> isAddedToBookmark(String id);
  Future<Either<Failure, List<Manga>>> getListBookmark();
}
