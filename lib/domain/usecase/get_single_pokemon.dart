import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_request_adapter/domain/repositories/pokemon_repository.dart';

import '../entitites/pokemon.dart';

abstract class GetSinglePokemonWithId {
  Future<Either<Failure, Pokemon>> call(String id);
}

class GetSinglePokemonWithIdImpl implements GetSinglePokemonWithId {
  final PokemonRepository repository;

  const GetSinglePokemonWithIdImpl(this.repository);

  @override
  Future<Either<Failure, Pokemon>> call(String id) async {
    return await repository.getSinglePokemon(id);
  }
}
