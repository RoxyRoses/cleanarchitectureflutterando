import 'package:cleanarchitecturefluterrando/app_module.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/usecases/search_by_text.dart';
import 'package:cleanarchitecturefluterrando/modules/search/external/datasources/github_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';


class DioMock extends Mock implements Dio{}
class SearchDatasourceImplMock extends Mock implements SearchDatasourceImpl{}
class SearchByTextImplMock extends Mock implements SearchByTextImpl{}
main() {
  final dioMock = DioMock();
  final datasourceMock = SearchDatasourceImplMock();
  final searchTextMock = SearchByTextImplMock();

  setUp((() {
    initModule(AppModule(), replaceBinds: [Bind.instance<Dio>(dioMock), Bind.instance<SearchByTextImpl>(searchTextMock), Bind.instance<SearchDatasourceImpl>(datasourceMock)]);
  }));

  test('Should recover the use case without error', (() {
    final dio = Modular.get<Dio>();
    expect(dio, isA<Dio>());
  }));

  // test('Should recover the use case', (() {
  //   final usecase = Modular.get<SearchByText>();
  //   expect(usecase, isA<SearchByTextImpl>());
  // }));

  // test('Should recover a list of ResultSearch', (() async {
  //   when(() => dioMock.get(any())).thenAnswer((_) async => Response(data: jsonDecode(githubResult), statusCode: 200, requestOptions: RequestOptions(path: '')));

  //   final usecase = Modular.get<SearchByText>();
  //   final result = await usecase('teste');

  //   expect(result | [], isA<List<ResultSearch>>());
  // }));
}
