part of 'pokemon_getter_cubit.dart';

@freezed
class PokemonGetterState with _$PokemonGetterState {
  const factory PokemonGetterState.initial() = _Initial;
  const factory PokemonGetterState.loading() = _Loading;
  const factory PokemonGetterState.success({
    required Pokemon pokemon,
  }) = _Sucess;
  const factory PokemonGetterState.error({
    required Failure failure,
  }) = _Error;
}
