import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_request_adapter/data/mappers/pokemon_mapper.dart';
import 'package:internal_apis/internal_apis.dart';

import '../../domain/entitites/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApi api;

  const PokemonRepositoryImpl({
    required this.api,
  });

  @override
  Future<Either<Failure, Pokemon>> getSinglePokemon(String idOrName) async {
    final result = await api.getSinglePokemon(idOrName: idOrName);
    return result.fold(
      (exception) => Left(exception.toFailure()),
      (data) => Right(PokemonMapper.toEntity(data)),
    );
  }
}
