import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newzent/data/app_exception.dart';
import 'package:newzent/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url,
      {Map<String, String>? headers, Map<String, String?>? params}) async {
    _logRequest(url, params);

    try {
      final uri = Uri.parse(url).replace(queryParameters: params);
      print(uri);
      final response = await http.get(uri, headers: headers);
      // .timeout(const Duration(seconds: 30));
      print(response.body);
      print("$uri get api");
      return _processResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on TimeoutException {
      throw RequestTimeOut('The request timed out');
    } on http.ClientException {
      throw InvalidUrlException('Invalid URL');
    }
  }

  @override
  Future<dynamic> postApi(dynamic data, String url,
      {Map<String, String>? headers, Map<String, String>? params}) async {
    _logRequest(url, params, data: data);

    try {
      final uri = Uri.parse(url).replace(queryParameters: params);
      final response = await http
          .post(uri, headers: headers, body: data)
          .timeout(const Duration(seconds: 10));
      return _processResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on TimeoutException {
      throw RequestTimeOut('The request timed out');
    } on http.ClientException {
      throw InvalidUrlException('Invalid URL');
    }
  }

  void _logRequest(String url, Map<String, String?>? params, {dynamic data}) {
    if (kDebugMode) {
      print('Request: $url');
      print('Params: $params');
      if (data != null) print('Data: $data');
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw FetchDataException('Bad request: ${response.body}');
      case 401:
        throw FetchDataException('Unauthorized: ${response.body}');
      case 403:
        throw FetchDataException('Forbidden: ${response.body}');
      case 404:
        throw FetchDataException('Not found: ${response.body}');
      case 500:
        throw ServerException('Internal server error: ${response.body}');
      default:
        throw FetchDataException(
            'Error occurred while communicating with server, status code: ${response.statusCode}');
    }
  }
}
