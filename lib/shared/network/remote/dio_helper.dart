import 'package:dio/dio.dart';

class DioHelper
{
  static Dio dio;

  DioHelper()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/',
        headers:
        {
          'Content-Type':'application/json',
          'Authorization' : 'key=AAAA1k17ojI:APA91bH7Nkq3gRjWJNn-Ix48rBF9O9vKi-Ev0yb0VCddugXqbQXcKaOsq5yN8mxL2nsB1XtrHQdTAN15KCZ3TLuzRoNj1kOemxhFDkadpcznd3lLx36ZhWc8mwwVLolwj29Q_RI_j17D'
        },
      ),
    );
  }

  static Future<Response> postNotification({path, data}) async
  {
    return await dio.post(
      path,
      data: data??null,
    );
  }

}