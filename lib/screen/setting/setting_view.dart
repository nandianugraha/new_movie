import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:new_movie_flutter/core/base/base_view.dart';
import 'package:new_movie_flutter/core/texts.dart';
import 'package:new_movie_flutter/data/repository/private/private_repository.dart';
import 'package:new_movie_flutter/r.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/screen/setting/setting_controller.dart';

class SettingView extends BaseView<SettingController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: true,
      leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      title: RichText(
          text: const TextSpan(
              text: 'SINTREN',
              style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
            TextSpan(
                text: ' INDRAMAYU',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
          ])),
    );
  }

  Widget content(
      String title, String content, Function()? ontap, IconData icon) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          onTap: ontap,
          leading: Icon(icon),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17),
                ),
              )
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.grey,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 50),
          height: 1,
          color: Colors.grey,
          width: MediaQuery.of(Get.context!).size.width,
        )
      ],
    );
  }

  Widget _buildScreen() {
    return controller.isLoading.value == true
        ? const LinearProgressIndicator(
            minHeight: 2,
          )
        : RefreshIndicator(
            onRefresh: controller.reset,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(bottom: 4),
                                child: Text(controller.name.value.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  controller.noHp.value,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  controller.alamat.value.isNotEmpty
                                      ? controller.alamat.value
                                      : ' -- ',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 60,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                  content("Profile", "", () {
                    Get.toNamed(MyRouter.profilepage)?.then((value) {
                      controller.reset();
                    });
                  }, Icons.person_outline),
                  content(
                      "Change Password", "", () {}, Icons.lock_open_outlined),
                  content(
                      "Terms and Conditions", "", () {}, Icons.info_outline),
                  content("FAQ", "", () {}, Icons.question_answer_outlined),
                  // Container(
                  //   margin: EdgeInsets.only(top: 10),
                  //   child: RaisedButton(
                  //     color: Colors.white,
                  //     onPressed: (){
                  //       FlutterOpenWhatsapp.sendSingleMessage("081911436650", "Hello");
                  //     },
                  //     child: DefaultText(
                  //       sizeText: 15,
                  //       textLabel: 'Hubungi Kami',
                  //     ),
                  //   ),
                  // ),
                  Container(
                    width: MediaQuery.of(Get.context!).size.width,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: TextButton(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text('Hubungi Kami',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ),
                      onPressed: () {
                        // launchWhatsApp(
                        //     phone: '6281911436650',
                        //     message: 'Hello Admin, saya $nama ingin');
                        // FlutterOpenWhatsapp.sendSingleMessage(
                        //     "6281911436650",
                        //     "Hello Admin, saya $nama ingin ....");
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(Get.context!).size.width,
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 100),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              spreadRadius: 10,
                              color: Colors.grey.shade200)
                        ],
                        border:
                            Border.all(color: Colors.grey.shade200, width: 1)),
                    child: TextButton(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'LOGOUT',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        controller.isLoading.value = true;
                        controller.logout();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  @override
  Widget body(BuildContext context) {
    Get.put(SettingController());
    return Scaffold(body: Obx((() => _buildScreen())));
  }
}
