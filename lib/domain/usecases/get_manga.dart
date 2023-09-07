import 'package:dartz/dartz.dart';
import 'package:read_manga_bloc/common/failure.dart';
import 'package:read_manga_bloc/domain/entities/manga.dart';
import 'package:read_manga_bloc/domain/repositories/manga_repository.dart';

class GetListManga {
  final MangaRepository repository;

  GetListManga(this.repository);

  Future<Either<Failure, List<Manga>>> execute(int page) {
    return repository.getManga(page);
  }
}
