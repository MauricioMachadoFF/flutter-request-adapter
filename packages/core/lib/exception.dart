import 'failures.dart';

abstract class CustomException implements Exception {
  final String? message;

  const CustomException({
    this.message,
  });

  Failure toFailure();

  @override
  String toString() {
    return 'Exception: $message';
  }
}

class NotFoundException extends CustomException {
  const NotFoundException({super.message});

  @override
  Failure toFailure() {
    return const NotFoundFailure();
  }
}

class UnhandledException extends CustomException {
  const UnhandledException({super.message});

  @override
  Failure toFailure() {
    return const UnhandledFailure();
  }
}
