import 'package:dartz/dartz.dart';
import 'package:flutter_request_adapter/core/exception.dart';

abstract class RequestClient {
  Future<Either<CustomException, dynamic>> get({
    required String path,
  });
}
