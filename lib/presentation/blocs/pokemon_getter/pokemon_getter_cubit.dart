import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_request_adapter/core/failures.dart';
import 'package:flutter_request_adapter/domain/usecase/get_single_pokemon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entitites/pokemon.dart';

part 'pokemon_getter_cubit.freezed.dart';
part 'pokemon_getter_state.dart';

class PokemonGetterCubit extends Cubit<PokemonGetterState> {
  final GetSinglePokemonWithId getSinglePokemonWithId;
  PokemonGetterCubit({
    required this.getSinglePokemonWithId,
  }) : super(const PokemonGetterState.initial());

  Future<void> searchPokemonById(
    String id,
  ) async {
    emit(const PokemonGetterState.loading());
    final pokemonDataOrFailure = await getSinglePokemonWithId(id);
    emit(
      pokemonDataOrFailure.fold(
        (failure) => PokemonGetterState.error(failure: failure),
        (pokemon) => PokemonGetterState.success(pokemon: pokemon),
      ),
    );
  }
}
