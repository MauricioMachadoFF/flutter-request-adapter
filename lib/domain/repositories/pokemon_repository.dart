import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entitites/pokemon.dart';

abstract class PokemonRepository {
  Future<Either<Failure, Pokemon>> getSinglePokemon(String idOrName);
}
