import 'package:cleanarchitecturefluterrando/modules/search/domain/errors/errors.dart';
import 'package:cleanarchitecturefluterrando/modules/search/infra/models/result_search_model.dart';
import 'package:dio/dio.dart';

import '../../infra/datasource/search_datasource.dart';

extension on String {
  normalize() {
    return replaceAll('', '+');
  }
}

class SearchDatasourceImpl implements SearchDatasource {
  final Dio dio;

  SearchDatasourceImpl(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio
        .get("https://api.github.com/search/users?q=${searchText.normalize()}");

    if (response.statusCode == 200) {
      final list = ((response.data['items'] as List)
          .map((e) => ResultSearchModel.fromMap(e))
          .toList());
      return list;
    } else {
      throw DataSourceError();
    }
  }
}
