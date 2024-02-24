import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:weather_app/Utils/logger.dart';

@injectable
class HttpInterceptor {

  HttpInterceptor();
  final http.Client _client = http.Client();
  static final Logger _logger = Logger(tag: 'HttpInterceptor');

  void printRequestInformation(http.BaseRequest request) {
    _logger..info('Request Uri: ${request.url}')
    ..info('Request Method: ${request.method}')
    ..info('Request Headers: ${request.headers}');
    if (request is http.Request) {
      _logger.info('Request Body: ${request.body}');
    } else if (request is http.MultipartRequest) {
      _logger..info('Multipart Request Fields: ${request.fields}')
      ..info('Multipart Request Files:');
      for (final file in request.files) {
        _logger..info('File name: ${file.filename}')
        ..info('File Content Type: ${file.contentType}')
        ..info('File Field: ${file.field}');
      }
    }
  }

  void printResponseInformation(http.Response response) {
    _logger..info('Response status code: ${response.statusCode}')
    ..info('Response body: ${response.body}');
  }

  Future<http.Response> onRequest(http.BaseRequest request) async {
    printRequestInformation(request);

    if (request is http.Request) {
      return _handleRequest(request);
    } else if (request is http.MultipartRequest) {
      return _handleMultipartRequest(request);
    }

    // Handle other request types as needed
    // For example, return an error response for unsupported request types
    return onError('Unsupported request type');
  }

  Future<http.Response> _handleRequest(http.Request request) async {
    final response = await _client.send(request);
    if (isValidResponse(response.statusCode)) {
      return onResponse(response);
    }

    return Future.error(response.statusCode);
  }

  Future<http.Response> _handleMultipartRequest(
      http.MultipartRequest request,) async {
    final response = await _client.send(request);

    if (isValidResponse(response.statusCode)) {
      return onResponse(response);
    }

    return Future.error(response.statusCode);
  }

  Future<http.Response> onResponse(http.StreamedResponse response) async {
    final result = await http.Response.fromStream(response);
    printResponseInformation(result);
    return result;
  }

  Future<http.Response> onError(Object error) {
    _logger.debug('Request failed: $error');
    return Future.error(error);
  }

  bool isValidResponse(int statusCode) => statusCode >= 200 && statusCode < 400;
}
