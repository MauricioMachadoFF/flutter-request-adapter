import '../../domain/entitites/pokemon.dart';

abstract class PokemonMapper {
  static Pokemon toEntity(Map<String, dynamic> response) {
    return Pokemon(
      name: response['name'],
    );
  }
}
