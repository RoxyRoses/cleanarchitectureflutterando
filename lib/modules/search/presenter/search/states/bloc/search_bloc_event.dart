part of 'search_bloc_bloc.dart';

@immutable
abstract class SearchBlocEvent {
  const SearchBlocEvent();
}

class SearchEvent extends SearchBlocEvent{
final String name;

const SearchEvent(this.name);

List<Object> get props => [name];

}
