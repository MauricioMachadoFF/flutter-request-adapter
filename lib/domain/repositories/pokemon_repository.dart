import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entitites/pokemon.dart';

abstract class PokemonRepository {
  Future<Either<Failure, Pokemon>> getSinglePokemon(String idOrName);
}
