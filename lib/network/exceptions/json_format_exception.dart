import 'package:new_movie_flutter/network/exceptions/base_exception.dart';

class JsonFormatException extends BaseException {
  JsonFormatException(String message) : super(message: message);
}
