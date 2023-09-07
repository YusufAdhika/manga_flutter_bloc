import 'package:dartz/dartz.dart';
import 'package:read_manga_bloc/common/failure.dart';
import 'package:read_manga_bloc/domain/entities/manga_detail.dart';
import 'package:read_manga_bloc/domain/repositories/manga_repository.dart';

class GetMangaDetail {
  final MangaRepository repository;

  GetMangaDetail(this.repository);

  Future<Either<Failure, MangaDetail>> execute(String id) {
    return repository.getMangaDetail(id);
  }
}
