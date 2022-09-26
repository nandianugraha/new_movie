import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:new_movie_flutter/core/base/base_view.dart';
import 'package:new_movie_flutter/screen/auth/login/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<LoginController>(() => LoginController());

    return SafeArea(
        child: SingleChildScrollView(
            child: Container(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Obx(() {
              return controller.isLoading.value == true
                  ? const LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      minHeight: 2,
                    )
                  : Container();
            }),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              style: const TextStyle(color: Color(0xff595959)),
              controller: controller.telpController,
              keyboardType: TextInputType.phone,
              focusNode: controller.telpFocus,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.smartphone,
                    color: controller.colorLogin,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff595959))),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff595959))),
                  labelText: 'Nomor Telepon',
                  labelStyle: const TextStyle(color: Color(0xff595959))),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                obscureText: !controller.showPassword,
                style: const TextStyle(color: Color(0xff595959)),
                controller: controller.passwordController,
                focusNode: controller.passwordFocus,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: Color(0xff595959)),
                  labelText: "Password",
                  labelStyle: const TextStyle(color: const Color(0xff595959)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff595959))),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff595959))),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.togglevisibility();
                    },
                    child: Icon(
                      controller.showPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: controller.colorLogin,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  textColor: const Color(0xff595959),
                  color: Colors.white,
                  child: const Text(
                    'MASUK',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    // AppRouter.makeFirst(context, MainScreen());
                    controller.loginAction(controller.telpController.text,
                        controller.passwordController.text);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
