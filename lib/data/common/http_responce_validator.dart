import 'package:dio/dio.dart';
import 'package:nike_ecommerce_flutter/common/exceptions.dart';

class HttpResponceValidator {
  validateResponce(Response responce) {
    if (responce.statusCode != 200) {
      throw AppException();
    }
  }
}
