
import 'package:cleanarchitecturefluterrando/modules/search/domain/entities/result_search.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

import '../usecases/search_by_text.dart';



abstract class SearchRepository{
  SearchByTextCallback search(String searchText) ;
}