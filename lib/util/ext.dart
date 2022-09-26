import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:new_movie_flutter/widget/status_dialog.dart';

String formatToDateTimeString(DateTime date, {String format = 'yyyy-MM-dd'}) {
  initializeDateFormatting();
  var formater = DateFormat(format, 'id');
  var now = formater.format(date);
  return now;
}

String getPrettyJSONString(jsonObject) {
  if (jsonObject is dio.FormData) {
    return "Form Data";
  }
  var encoder = const JsonEncoder.withIndent("  ");
  return encoder.convert(jsonObject);
}

void showSnackbar(String msg) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(msg)));
}

void errorDialog(String? msg) {
  Get.dialog(
    StatusDialog(
      title: 'ERROR',
      desc: msg ?? '',
      status: StatusType.error,
    ),
  );
}

imageCache(String url, {double? width, BoxFit? box}) {
  Image.network(
    url,
    width: width,
    fit: box,
    // loadingBuilder:
    //     (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
    //   if (loadingProgress == null) {
    //     return child;
    //   }
    //   return Center(
    //     child: CircularProgressIndicator(
    //       value: loadingProgress.expectedTotalBytes != null
    //           ? loadingProgress.cumulativeBytesLoaded /
    //               loadingProgress.expectedTotalBytes
    //           : null,
    //     ),
    //   );
    // },
  );
}

Widget textField(IconData icon, String name, TextEditingController controller,
    TextInputType inputType, Color color,
    // String validator,
    {FormFieldValidator<String>? validator,
    bool? haveIcon,
    Function()? onTap,
    String? helper}) {
  return Column(
    children: [
      Container(
        child: TextFormField(
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return validator;
          //   }
          //   return null;
          // },
          validator: validator,
          keyboardType: inputType,
          controller: controller,
          style: TextStyle(color: color),
          decoration: InputDecoration(
              suffixIcon: haveIcon == true
                  ? GestureDetector(
                      onTap: onTap, child: Icon(Icons.add, color: color))
                  : null,
              prefixIcon: Icon(
                icon,
                color: color,
              ),
              hoverColor: Colors.grey,
              enabledBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: color)),
              focusedBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: color)),
              labelText: name,
              helperText: helper,
              helperStyle: const TextStyle(fontSize: 12),
              labelStyle: TextStyle(color: color, fontSize: 15),
              hintStyle: TextStyle(
                color: color,
              )),
        ),
      ),
    ],
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
