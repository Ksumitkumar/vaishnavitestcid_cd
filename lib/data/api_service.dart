import 'package:dio/dio.dart';
import 'package:untitled4/core/app_constants.dart';
import 'package:untitled4/data/models/user_models.dart';

class ApiService {
  final Dio dio;
  ApiService()
    : dio = Dio(
        BaseOptions(
          baseUrl: AppConstants.BASE_URL,
          receiveTimeout: Duration(seconds: 10),
          sendTimeout: Duration(seconds: 10),
          headers: {
            'Content-Type': 'application-json',
            'Accept': 'application-json',
          },
        ),
      ) {
    LogInterceptor(request: true, requestBody: true, responseBody: true);
    InterceptorsWrapper(
      onRequest: (requestInterceptor, requestHandler) {
        requestInterceptor.headers['Authorization'] =
            'Bearer ' + ' your token here';
        requestHandler.next(requestInterceptor);
      },
      onResponse: ((response, handler) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          print("User get success data");
        }
        handler.next(response);
      }),
      onError: (dioError, handler) {
        handler.next(dioError);
      },
    );
  }

  Future<List<UserModels>> getUserList() async {
    var response = await dio.get(AppConstants.todos);
    List responseData = response.data;
    return responseData.map((json) => UserModels.fromJson(json)).toList();
  }
}
