import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({
    this.message,
  });

  @override
  List get props => [message];
}

class UnhandledFailure extends Failure {
  const UnhandledFailure({super.message});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure();
}
