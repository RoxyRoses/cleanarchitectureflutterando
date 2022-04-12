import 'package:cleanarchitecturefluterrando/modules/search/presenter/search/states/bloc/search_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBlocBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Search'),
      ),
      body: Column(
        children: <Widget>[
           Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8, top: 8),
            child: TextField(
              onChanged: (value) {
                print(value);
                bloc.add(SearchEvent(value));},
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Search'),
            ),
          ),
          Expanded(
              child: BlocBuilder<SearchBlocBloc, SearchBlocState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is StartSearchState) {
                      return const Center(
                        child: Text('Digite um texto'),
                      );
                    }
                    if (state is ErrorSearchState) {
                      return const Center(
                        child: Text('Houve um erro'),
                      );
                    }

                    if (state is LoadSearchState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is BlocSearchInitial) {
                      return const Center(
                        child: Text('Initial'),
                      );
                    }
                    final list = (state as SuccessSearchState).result;
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, id) {
                      final item = list[id];
                      return ListTile(
                        leading: item.img == null ? Container() : CircleAvatar(backgroundImage: NetworkImage(item.img) ),
                        title: Text(item.title ?? ""),
                        subtitle: Text(item.content),
                      );
                    });
                  })),
        ],
      ),
    );
  }
}
