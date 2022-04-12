import '../usecases/search_by_text.dart';



abstract class SearchRepository{
  SearchByTextCallback search(String searchText) ;
}