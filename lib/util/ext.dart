import 'dart:convert';

import 'package:dio/dio.dart' as dio;

String getPrettyJSONString(jsonObject) {
  if (jsonObject is dio.FormData) {
    return "Form Data";
  }
  var encoder = const JsonEncoder.withIndent("  ");
  return encoder.convert(jsonObject);
}
