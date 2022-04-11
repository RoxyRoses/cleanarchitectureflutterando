import 'package:cleanarchitecturefluterrando/modules/search/domain/entities/result_search.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/errors/errors.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/repositories/search_repository.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/usecases/search_by_text.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchRepositoryMock();
  final usecase = SearchByTextImpl(repository);

  test('Should return a list of ResultSearch', (() async {
    when(() => repository.search(any()))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    final result = await usecase('teste');

    expect(result | [], isA<List<ResultSearch>>());
  }));

  test('Should return a exception if the text is invalid', (() async {
    when(() => repository.search(any()))
        .thenAnswer((_) async => const Right(<ResultSearch>[]));

    var result = await usecase('');

    expect(result.fold(id, id), isA<InvalidTextError>());

  }));
}
