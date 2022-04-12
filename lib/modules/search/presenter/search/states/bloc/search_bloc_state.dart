part of 'search_bloc_bloc.dart';

@immutable
abstract class SearchBlocState {}

class BlocSearchInitial extends SearchBlocState {
  @override
  List<Object> get props => [];
}

class StartSearchState extends SearchBlocState{
  @override
  List<Object>? get props => null;
}

class LoadSearchState extends SearchBlocState{
  @override
  List<Object>? get props => null;
}

class SuccessSearchState extends SearchBlocState{
final List<ResultSearch> result;

 SuccessSearchState(this.result);

  @override
  List<Object>? get props => [result];
}

class ErrorSearchState extends SearchBlocState{
  final String message;

   ErrorSearchState({this.message = ''});

  @override
  List<Object> get props => [message];

}
