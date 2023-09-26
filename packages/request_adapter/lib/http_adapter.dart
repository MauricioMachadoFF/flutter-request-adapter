import 'dart:convert';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import 'request_client.dart';

class HttpAdapter implements RequestClient {
  final Client _client;
  final String baseUrl;

  HttpAdapter({
    required this.baseUrl,
  }) : _client = Client();

  @override
  Future<Either<CustomException, dynamic>> get({
    required String path,
  }) async {
    try {
      final url = Uri.parse(baseUrl + path);
      final result = await _client.get(url);
      final exception = _mapStatusCodeToException(result.statusCode);
      if (exception != null) {
        return Left(exception);
      }
      final Map<String, dynamic> decodedResponse = jsonDecode(
        utf8.decode(
          result.bodyBytes,
        ),
      ) as Map<String, dynamic>;
      return Right(decodedResponse);
    } catch (e) {
      return const Left(UnhandledException());
    }
  }

  CustomException? _mapStatusCodeToException(int statusCode) {
    switch (statusCode) {
      case 404:
        return const NotFoundException();
      case 500:
      default:
        return const UnhandledException();
    }
  }
}
