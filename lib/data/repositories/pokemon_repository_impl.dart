import 'package:dartz/dartz.dart';
import 'package:flutter_request_adapter/adapters/request_client.dart';
import 'package:flutter_request_adapter/data/mappers/pokemon_mapper.dart';

import '../../core/failures.dart';
import '../../domain/entitites/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final RequestClient apiClient;

  const PokemonRepositoryImpl({
    required this.apiClient,
  });

  @override
  Future<Either<Failure, Pokemon>> getSinglePokemon(String idOrName) async {
    final result = await apiClient.get(
      path: 'pokemon-species/$idOrName',
    );
    return result.fold(
      (exception) => Left(exception.toFailure()),
      (data) => Right(PokemonMapper.toEntity(data)),
    );
  }
}
