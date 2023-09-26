import 'package:request_adapter/request_adapter.dart';

abstract class BaseApi {
  final RequestClient client;

  const BaseApi({
    required this.client,
  });
}
