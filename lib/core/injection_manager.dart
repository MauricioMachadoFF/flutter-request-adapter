import 'package:internal_apis/internal_apis.dart';
import 'package:request_adapter/request_adapter.dart';

import 'package:flutter_request_adapter/core/injection.dart';
import 'package:flutter_request_adapter/data/repositories/pokemon_repository_impl.dart';
import 'package:flutter_request_adapter/domain/repositories/pokemon_repository.dart';
import 'package:flutter_request_adapter/domain/usecase/get_single_pokemon.dart';

class InjectionManager {
  void injectDependencies() {
    getIt.registerFactory<PokemonRepository>(
      () => PokemonRepositoryImpl(
        api: PokemonApi(),
      ),
    );
    getIt.registerFactory<GetSinglePokemonWithId>(
      () => GetSinglePokemonWithIdImpl(
        getIt.get(),
      ),
    );
  }
}
