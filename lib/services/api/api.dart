import 'package:dio/dio.dart';


class ApiService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://127.0.0.1:8000/api', //ou http://10.0.2.2:3000/api pour l'émulateur android 
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  }