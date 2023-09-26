import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class RequestClient {
  Future<Either<CustomException, dynamic>> get({
    required String path,
  });
}
