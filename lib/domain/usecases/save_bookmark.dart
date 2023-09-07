import 'package:dartz/dartz.dart';
import 'package:read_manga_bloc/common/failure.dart';
import 'package:read_manga_bloc/domain/entities/manga_detail.dart';
import 'package:read_manga_bloc/domain/repositories/manga_repository.dart';

class SaveBookmark {
  final MangaRepository repository;

  SaveBookmark(this.repository);

  Future<Either<Failure, String>> execute(MangaDetail movie) {
    return repository.saveBookmark(movie);
  }
}
