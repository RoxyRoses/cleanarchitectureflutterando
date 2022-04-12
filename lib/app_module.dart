import 'package:cleanarchitecturefluterrando/app_widget.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/repositories/search_repository.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/usecases/search_by_text.dart';
import 'package:cleanarchitecturefluterrando/modules/search/external/datasources/github_datasource.dart';
import 'package:cleanarchitecturefluterrando/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:cleanarchitecturefluterrando/modules/search/presenter/search/search_page.dart';
import 'package:cleanarchitecturefluterrando/modules/search/presenter/search/states/bloc/search_bloc_bloc.dart';
import 'package:cleanarchitecturefluterrando/modules/shared/debouncer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => (i())),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchDatasourceImpl(i())),
        Bind((i) => Dio()),
        Bind((i) => SearchBlocBloc(i(),i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => Debouncer(milliseconds: 1000)),
      ];

  Widget get bootstrap => const MyApp();

  @override
  List<ModularRoute> get routes =>
      [ChildRoute(Modular.initialRoute, child: (_, __) => const SearchPage())];
}
