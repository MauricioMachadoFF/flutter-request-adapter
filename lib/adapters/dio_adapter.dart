import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_request_adapter/core/exception.dart';

import 'request_client.dart';

class DioAdapter implements RequestClient {
  final Dio dioInstace;

  const DioAdapter({
    required this.dioInstace,
  });

  @override
  Future<Either<CustomException, dynamic>> get({
    required String path,
  }) async {
    try {
      final result = await dioInstace.get(path);
      return result.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const Left(NotFoundException());
      }
      rethrow;
    } catch (e) {
      return const Left(UnhandledException());
    }
  }
}
