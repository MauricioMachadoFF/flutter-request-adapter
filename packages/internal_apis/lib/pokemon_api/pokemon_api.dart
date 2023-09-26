import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:request_adapter/request_adapter.dart';

import '../base_api.dart';

class PokemonApi implements BaseApi {
  Future<Either<CustomException, dynamic>> getSinglePokemon({
    required String idOrName,
  }) async {
    final result = await client.get(
      path: 'pokemon-species/$idOrName',
    );
    return result;
  }

  @override
  RequestClient get client => DioAdapter(baseUrl: 'https://pokeapi.co/api/v2/');
}
