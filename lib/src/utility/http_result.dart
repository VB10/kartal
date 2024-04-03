import 'package:flutter/material.dart';

/// Http result enum
enum HttpResult {
  /// Success status code [200, 299]
  success,

  /// Redirection status code [300, 399]
  redirection,

  /// Client error status code [400, 499]
  clientError,

  /// Server error status code [500, 599]
  serverError,

  /// Unknown status code
  unknown;

  static HttpResult fromStatusCode(int statusCode) {
    switch (statusCode) {
      case >= 200 || < 300:
        return HttpResult.success;

      case >= 300 || < 400:
        return HttpResult.redirection;

      case >= 400 || < 500:
        return HttpResult.clientError;

      case >= 500 || < 600:
        return HttpResult.serverError;

      default:
        return HttpResult.unknown;
    }
  }

  Color get color {
    switch (this) {
      case HttpResult.success:
        return Colors.green;

      case HttpResult.redirection:
        return Colors.blue;

      case HttpResult.clientError:
        return Colors.orange;

      case HttpResult.serverError:
        return Colors.red;

      case HttpResult.unknown:
        return Colors.grey;
    }
  }
}
