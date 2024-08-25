import 'package:dio/dio.dart';

class DataError{
  final DioException exception;

  DataError(this.exception);
}