import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/model/req/req_register.dart';
import 'package:new_movie_flutter/screen/auth/register/register_controller.dart';
import 'package:new_movie_flutter/util/ext.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<RegisterController>(() => RegisterController());

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
              textField(
                  Icons.people_alt,
                  'Nama Lengkap',
                  controller.name,
                  TextInputType.name,
                  controller.colorRegister, validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Silahkan masukkan nama lengkap anda!';
                }
                return null;
              }),
              textField(
                  Icons.smartphone,
                  'Telepon',
                  controller.telp,
                  TextInputType.phone,
                  controller.colorRegister, validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Silahkan masukkan nomor telepon anda!';
                }
                return null;
              }),

              textField(
                  Icons.home,
                  'Alamat',
                  controller.alamat,
                  TextInputType.text,
                  controller.colorRegister, validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Silahkan masukan alamat lengkap anda!';
                }
                return null;
              }),
              textField(
                  Icons.directions_boat,
                  'Nama Kapal (Wajib Diisi)',
                  controller.kapal1,
                  TextInputType.text,
                  controller.colorRegister, validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Silahkan masukan minimal satu nama kapal anda, dari 3 form ini!';
                }
                return null;
              }),
              textField(Icons.directions_boat, 'Nama Kapal', controller.kapal2,
                  TextInputType.text, controller.colorRegister,
                  helper: '(optional/tidak wajib diisi)'),
              // 'Silahkan masukan kapal anda!',
              textField(Icons.directions_boat, 'Nama Kapal', controller.kapal3,
                  TextInputType.text, controller.colorRegister,
                  helper: '(optional/tidak wajib diisi)'),
              // 'Silahkan masukan kapal anda!',
              Container(
                margin:
                    const EdgeInsets.only(left: 0, top: 4, right: 0, bottom: 4),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silahkan masukkan Password anda!';
                    } else if (value.length <= 6) {
                      return 'Silahkan masukkan Password minimal 6 karakter!';
                    }
                    return null;
                  },
                  style: TextStyle(color: controller.colorRegister),
                  obscureText: !controller.showPassword,
                  controller: controller.password,
                  decoration: InputDecoration(
                    hoverColor: Colors.grey,
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: controller.colorRegister)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: controller.colorRegister)),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: controller.colorRegister, fontSize: 15),
                    hintStyle: TextStyle(color: controller.colorRegister),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.showPassword = !controller.showPassword;
                      },
                      child: Icon(
                        controller.showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: controller.colorRegister,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(left: 0, top: 4, right: 0, bottom: 4),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silahkan masukkan konfirmasi Password anda';
                    }
                    if (value != controller.confPassword.text) {
                      return 'Konfirmasi password anda tidak sama dengan password anda';
                    }
                    return null;
                  },
                  obscureText: !controller.showConfPassword,
                  style: TextStyle(color: controller.colorRegister),
                  controller: controller.confPassword,
                  decoration: InputDecoration(
                    hoverColor: Colors.grey,
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: controller.colorRegister)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: controller.colorRegister)),
                    labelText: 'Konfirmasi Password',
                    labelStyle: TextStyle(
                        color: controller.colorRegister, fontSize: 15),
                    hintStyle: TextStyle(color: controller.colorRegister),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.showConfPassword =
                            !controller.showConfPassword;
                      },
                      child: Icon(
                        controller.showConfPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: controller.colorRegister,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 300),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    textColor: controller.colorRegister,
                    color: Colors.white,
                    child: const Text(
                      'DAFTAR',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      // if (_formKey.currentState.validate()) {
                      controller.registerAction(ReqRegisterModel(
                          name: controller.name.text,
                          telp: controller.telp.text,
                          alamat: controller.alamat.text,
                          kapal1: controller.kapal1.text,
                          kapal2: controller.kapal2.text,
                          kapal3: controller.kapal3.text,
                          password: controller.password.text,
                          confPassword: controller.confPassword.text));
                      // }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
