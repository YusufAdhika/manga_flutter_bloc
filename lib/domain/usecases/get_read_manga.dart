import 'package:dartz/dartz.dart';
import 'package:read_manga_bloc/common/failure.dart';
import 'package:read_manga_bloc/domain/entities/read_manga.dart';
import 'package:read_manga_bloc/domain/repositories/manga_repository.dart';

class GetReadManga {
  final MangaRepository repository;

  GetReadManga(this.repository);

  Future<Either<Failure, List<ReadManga>>> execute(String id) {
    return repository.getReadManga(id);
  }
}
