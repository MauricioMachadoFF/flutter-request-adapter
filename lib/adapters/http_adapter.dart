import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_request_adapter/core/exception.dart';
import 'package:http/http.dart';

import 'request_client.dart';

class HttpAdapter implements RequestClient {
  final Client client;
  final String baseUrl;
  const HttpAdapter({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<Either<CustomException, dynamic>> get({
    required String path,
  }) async {
    try {
      final url = Uri.parse(baseUrl + path);
      final result = await client.get(url);
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
        return const UnhandledException();
    }
  }
}
