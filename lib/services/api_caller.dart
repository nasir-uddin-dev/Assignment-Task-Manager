import 'dart:convert';
import 'package:http/http.dart';

class ApiCaller {
  static Future<ApiResponse> _postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      Response response = await post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          responseCode: statusCode,
          responseData: decodedData,
        );
      } else {
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: decodedData['data'],
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }
}

///Make Reference Class
class ApiResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic responseData;
  final String? errorMessage;

  ApiResponse({
    required this.isSuccess,
    required this.responseCode,
    required this.responseData,
    this.errorMessage = "Something went wrong",

    ///default error Message
  });
}
