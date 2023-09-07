import 'package:dartz/dartz.dart';
import 'package:read_manga_bloc/common/failure.dart';
import 'package:read_manga_bloc/domain/entities/manga.dart';
import 'package:read_manga_bloc/domain/repositories/manga_repository.dart';

class GetBookmarklistManga {
  final MangaRepository _repository;

  GetBookmarklistManga(this._repository);

  Future<Either<Failure, List<Manga>>> execute() {
    return _repository.getListBookmark();
  }
}
