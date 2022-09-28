import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_view.dart';
import 'package:new_movie_flutter/core/texts.dart';
import 'package:new_movie_flutter/screen/setting/profile/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  Widget _buildScreen() {
    return WillPopScope(onWillPop: () => Future.value(true), child: content());
  }

  Widget _profile(
      BuildContext context,
      String title,
      String label,
      TextEditingController controllers,
      TextInputType keyboardType,
      FocusNode focus,
      int? maxLength,
      Function func) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(
                  color: controller.isEdit.value ? Colors.grey : Colors.white,
                  width: 1)),
          child: TextFormField(
            maxLines: title == 'Alamat' ? 3 : 1,
            maxLength: maxLength!,
            keyboardType: keyboardType,
            inputFormatters: [
              // ignore: missing_required_param
              keyboardType == TextInputType.number ||
                      keyboardType == TextInputType.phone
                  ? FilteringTextInputFormatter.digitsOnly
                  : FilteringTextInputFormatter.allow(
                      RegExp("[A-Za-z0-9!@#%^&*()_+={}:;<>,./? ]")),
            ],
            decoration: InputDecoration(
                hintText: title,
                // labelText: label,
                labelStyle: const TextStyle(color: Color(0xff001D48)),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                counterText: ''),
            controller: controllers,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Color(0xff001D48)),
            enabled: controller.isEdit.value,
            onChanged: (s) {
              if (controller.isEdit.value) {
                controller.checkValid();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              height: 1,
              decoration:
                  BoxDecoration(color: Colors.grey.shade200, boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1)
              ])),
          controller.isLoading.value
              ? const LinearProgressIndicator(
                  backgroundColor: Colors.cyan,
                  minHeight: 2,
                )
              : Container(),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: [
                        BoxShadow(
                          color: controller.isEdit.value
                              ? Colors.grey.withOpacity(0.0)
                              : Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white),
                  margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 40),
                      child: Column(
                        children: [
                          const Text(
                            'Data Diri',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            thickness: 2,
                            indent: 10,
                            endIndent: 10,
                            height: 10,
                          ),
                          _profile(
                              Get.context!,
                              'Nomor HP',
                              "",
                              controller.phoneController,
                              TextInputType.phone,
                              controller.phoneFocus,
                              13,
                              () {}),
                          _profile(
                              Get.context!,
                              'Nama Lengkap',
                              "",
                              controller.nameController,
                              TextInputType.name,
                              controller.nameFocus,
                              30,
                              () {}),
                          _profile(
                              Get.context!,
                              'Alamat',
                              "",
                              controller.alamatController,
                              TextInputType.text,
                              controller.alamatFocus,
                              100,
                              () {}),
                        ],
                      )),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 48, bottom: 30),
            child: RaisedButton(
              padding: const EdgeInsets.only(
                  left: 50, right: 50, top: 15, bottom: 15),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              textColor: Colors.white,
              color: !controller.isEdit.value
                  ? Colors.red
                  : controller.isReady.value
                      ? Colors.red
                      : Colors.red.shade200,
              child: Text(
                '${controller.button}',
                style: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                if (!controller.isLoading.value) {
                  if (!controller.isEdit.value) {
                    controller.appBar.value = 'Edit Profile';
                    controller.button.value = 'Save';
                    controller.isEdit.value = true;
                    controller.setData();
                    controller.update();
                  } else {
                    // ignore: unnecessary_statements
                    controller.isReady.value ? controller.saveProfile() : null;
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx((() => Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              leading: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
              title: Text(controller.appBar.value,
                  style: const TextStyle(color: Colors.black))),
          body: _buildScreen(),
        )));
  }
}
