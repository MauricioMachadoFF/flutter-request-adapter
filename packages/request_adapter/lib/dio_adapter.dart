import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'request_client.dart';

class DioAdapter implements RequestClient {
  final String baseUrl;
  final Duration? connectionTimeout;
  final Duration? receiveTimeout;
  final Dio _dio;

  DioAdapter({
    required this.baseUrl,
    this.connectionTimeout = const Duration(seconds: 5),
    this.receiveTimeout = const Duration(seconds: 3),
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: connectionTimeout,
            receiveTimeout: receiveTimeout,
          ),
        );

  @override
  Future<Either<CustomException, dynamic>> get({
    required String path,
  }) async {
    try {
      final result = await _dio.get(path);
      return Right(result.data);
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
