import 'package:algo_test/model/meme_model.dart';
import 'package:dio/dio.dart';

class Api{
  Dio? _dio;

  String _baseUrl = "https://api.imgflip.com";

  Api() {
    BaseOptions options = BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        receiveTimeout: Duration(milliseconds: 1000000),
        connectTimeout: Duration(milliseconds: 1000000),
        baseUrl: _baseUrl,
        contentType: Headers.jsonContentType);
    _dio = Dio(options);
  }

  Future<MemeModel?> fetchMeme() async {
    try {
      final resp = await _dio?.get("/get_memes");
      return MemeModel.fromJson(resp?.data);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}