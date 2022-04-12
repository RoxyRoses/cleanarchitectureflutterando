import 'package:bloc_test/bloc_test.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/entities/result_search.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/errors/errors.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/usecases/search_by_text.dart';
import 'package:cleanarchitecturefluterrando/modules/search/presenter/search/states/bloc/search_bloc_bloc.dart';
import 'package:cleanarchitecturefluterrando/modules/shared/debouncer.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class UseCaseMock extends Mock implements SearchByText {}

main() {
  final useCase = UseCaseMock();
  final bloc = SearchBlocBloc(useCase, Debouncer(milliseconds: 0));

  blocTest<SearchBlocBloc, SearchBlocState>(
    'Should return the states in correct order',
    build: () {
          when(() => useCase.call(any())).thenAnswer((_) async =>  Right(<ResultSearch>[ResultSearch(title: 'title', content: 'content', img: 'img')]));

      return bloc;
    },
    act: (bloc) => bloc.add(const SearchEvent('teste')),
    expect: () => [isA<LoadSearchState>(), isA<SuccessSearchState>()],
  );

   blocTest<SearchBlocBloc, SearchBlocState>(
    'Should return error',
    build: () {
          when(() => useCase.call(any(),),).thenAnswer((_) async =>  Left(DataSourceError()));

      return SearchBlocBloc(useCase, Debouncer(milliseconds: 0));
    },
    act: (bloc) => bloc.add(const SearchEvent('')),
    expect: () => [isA<LoadSearchState>(), isA<ErrorSearchState>()],
  );
}
