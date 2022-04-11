import 'package:cleanarchitecturefluterrando/modules/search/domain/entities/result_search.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/errors/errors.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

typedef SearchByTextCallback
    = Future<Either<FailureSearch, List<ResultSearch>>>;

abstract class SearchByText {
  SearchByTextCallback call(String searchText);
}

class SearchByTextImpl implements SearchByText {
  final SearchRepository repository;

  SearchByTextImpl(this.repository);

  @override
  SearchByTextCallback call(String searchText) async {
    if (searchText.isEmpty) {
      return Left(InvalidTextError());
    }
    return repository.search(searchText);
  }
}
