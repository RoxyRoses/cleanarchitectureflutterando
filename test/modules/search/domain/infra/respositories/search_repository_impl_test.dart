import 'package:cleanarchitecturefluterrando/modules/search/domain/errors/errors.dart';
import 'package:cleanarchitecturefluterrando/modules/search/infra/datasource/search_datasource.dart';
import 'package:cleanarchitecturefluterrando/modules/search/infra/models/result_search_model.dart';
import 'package:cleanarchitecturefluterrando/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchDataSourceMock extends Mock implements SearchDatasource {}

main() {
  final datasource = SearchDataSourceMock();

  final repository = SearchRepositoryImpl(datasource);

  test('Should return a list of ResultSearch', () async {
    when(() => datasource.getSearch(any()))
        .thenAnswer((_) async => <ResultSearchModel>[]);

    final result = await repository.search('teste');

    expect(result | [], isA<List<ResultSearchModel>>());
  });

   test('Should return a exception if the datasource fails', (() async {
    when(() => datasource.getSearch(any()))
        .thenThrow(Exception());

    final result = await repository.search('teste');

    expect(result.fold(id, id), isA<DataSourceError>());

  }));
}
