import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_request_adapter/presentation/blocs/pokemon_getter/pokemon_getter_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'Input ID or pokemon name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              BlocBuilder<PokemonGetterCubit, PokemonGetterState>(
                builder: (_, state) => state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  error: (failure) => Column(
                    children: [
                      Text(
                        _getFailureTextBasedOnFailure(failure),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                  success: (pokemon) => Column(
                    children: [
                      Text(
                        pokemon.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.all(8),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        16,
                      ),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        16,
                      ),
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              const Spacer(flex: 2),
              SizedBox(
                width: double.maxFinite,
                height: 48,
                child: BlocBuilder<PokemonGetterCubit, PokemonGetterState>(
                  builder: (_, state) => state.maybeWhen(
                    orElse: () => ElevatedButton(
                      onPressed: () {
                        context.read<PokemonGetterCubit>().searchPokemonById(
                              _controller.text,
                            );
                      },
                      child: const Text('Search'),
                    ),
                    loading: () => ElevatedButton(
                      onPressed: () {},
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String _getFailureTextBasedOnFailure(Failure failure) {
    if (failure is NotFoundFailure) {
      return "There's not corresponding pokemon to the input you inserted";
    }
    return "Ops! Something went wrong and we couldnt complete your search";
  }
}
