import 'dart:convert';

import 'package:cleanarchitecturefluterrando/modules/search/domain/errors/errors.dart';
import 'package:cleanarchitecturefluterrando/modules/search/external/datasources/github_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio{

}
main(){

final dio = DioMock();

  final datasource = SearchDatasourceImpl(dio);
  test('Should return a list of resultSearchModel', () async{
    when(() => dio.get(any())).thenAnswer((_) async => Response(data: jsonDecode(githubResult), statusCode: 200, requestOptions: RequestOptions(path: '')));

    final future = datasource.getSearch('searchText');

    expect(future, completes);
  });

  test('Should return an error if code its not 200', () async{
    when(() => dio.get(any())).thenAnswer((_) async => Response(data: null, statusCode: 401, requestOptions: RequestOptions(path: '')));

    final future = datasource.getSearch('searchText');

    expect(future, throwsA(isA<DataSourceError>())); 
  });

  test('Should return an error if theres an error on dio', () async{
    when(() => dio.get(any())).thenThrow(Exception());

    final future = datasource.getSearch('searchText');

    expect(future, throwsA(isA<Exception>())); 
  });
}

