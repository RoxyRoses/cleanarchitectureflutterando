import 'package:bloc/bloc.dart';
import 'package:cleanarchitecturefluterrando/modules/search/domain/usecases/search_by_text.dart';
import 'package:cleanarchitecturefluterrando/modules/shared/debouncer.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/entities/result_search.dart';

part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBlocBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  final SearchByText usecase;
  final Debouncer debouncer;

  SearchBlocBloc(this.usecase, this.debouncer) : super(BlocSearchInitial()) {
    on<SearchEvent>(_searchName, transformer: debounceTransformer(Duration(milliseconds: 1000)));
  }

  void _searchName(SearchEvent event, Emitter<SearchBlocState> emit) async {
    print(event.name + 'bloc');

    //debouncer.run(() async {
      print(event.name + 'run');

      emit(LoadSearchState());

      final result = await usecase.call(event.name);
      emit.isDone;
      await result.fold(
          (l) async => emit(ErrorSearchState(message: 'something went wrong')),
          (r) async {
        await Future.delayed(const Duration(seconds: 2));
        if (r.isEmpty) {
          return emit(ErrorSearchState(message: 'something went wrong'));
        }

        return emit(SuccessSearchState(r));
      });
    //});
  }
  
  EventTransformer<Event> debounceTransformer<Event>(Duration duration) {
  return (events, mapper) {
    return events.debounceTime(duration).asyncExpand(mapper);
  };
}
}

