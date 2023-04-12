import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HttpsClient {
  static String domain = "http://192.168.30.7:8082/api/";

  static Dio dio = Dio();

  HttpsClient() {
    dio.options.baseUrl = domain;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
  }

  Future get(apiUrl) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    try {
      var response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            version: version, // Set the content-length.
          },
        ),
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  Future post(String apiUrl, {Map? data}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    try {
      var response = await dio.post(
        domain + apiUrl,
        data: data,
        options: Options(
          headers: {
            version: version, // Set the content-length.
          },
        ),
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  static replaeUri(picUrl) {
    String tempUrl = domain + picUrl;
    return tempUrl.replaceAll("\\", "/");
  }
}
