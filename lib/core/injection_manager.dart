import 'package:flutter_request_adapter/adapters/http_adapter.dart';
import 'package:flutter_request_adapter/adapters/request_client.dart';
import 'package:flutter_request_adapter/core/injection.dart';
import 'package:flutter_request_adapter/data/repositories/pokemon_repository_impl.dart';
import 'package:flutter_request_adapter/domain/repositories/pokemon_repository.dart';
import 'package:flutter_request_adapter/domain/usecase/get_single_pokemon.dart';
import 'package:http/http.dart';

class InjectionManager {
  void injectDependencies() {
    getIt.registerSingleton<RequestClient>(
      // DioAdapter(
      //   dioInstace: Dio(
      //     BaseOptions(
      //       baseUrl: 'https://pokeapi.co/api/v2/',
      //       connectTimeout: const Duration(seconds: 5),
      //       receiveTimeout: const Duration(seconds: 3),
      //     ),
      //   ),
      HttpAdapter(
        client: Client(),
        baseUrl: 'https://pokeapi.co/api/v2/',
      ),
    );
    getIt.registerFactory<PokemonRepository>(
      () => PokemonRepositoryImpl(
        apiClient: getIt.get(),
      ),
    );
    getIt.registerFactory<GetSinglePokemonWithId>(
      () => GetSinglePokemonWithIdImpl(
        getIt.get(),
      ),
    );
  }
}
