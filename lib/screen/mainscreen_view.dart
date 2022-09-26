import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/screen/cuaca/cuaca_controller.dart';
import 'package:new_movie_flutter/screen/mainscreen_controller.dart';

import '../r.dart';

class MainScreenView extends GetView<MainScreenController> {
  const MainScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CuacaController());
    return Obx((() => Scaffold(
        appBar: controller.pos.value == 0
            ? null
            : AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
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
                actions: [
                  InkWell(
                    onTap: () => Get.toNamed(MyRouter.settingscreen),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomAppBar(
            elevation: 5.0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const CircularNotchedRectangle(),
            notchMargin: 6,
            child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.cyanAccent.shade700,
                currentIndex: controller.pos.value,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      controller.pos.value = 0;
                      break;
                    case 1:
                      controller.pos.value = 1;
                      break;
                  }
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: controller.pos.value == 0
                            ? Colors.cyanAccent.shade700
                            : Colors.grey,
                      ),
                      label: 'Beranda'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.cloud,
                        color: controller.pos.value == 1
                            ? Colors.cyanAccent.shade700
                            : Colors.grey,
                      ),
                      label: 'Cuaca'),
                ]),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
            width: 80,
            height: 80,
            child: FloatingActionButton(
              onPressed: () {
                // Preferences.getKapalId().then((valueKapalId) {
                //   print(valueKapalId);
                //   if (valueKapalId == '' || valueKapalId == 'null') {
                //     Toast.show('Anda belum memilih kapal',
                //         duration: Toast.lengthShort, gravity: Toast.bottom);
                //   } else {
                //     AppRouter.push(
                //         context,
                //         SOSScreen(
                //           kapalId: valueKapalId,
                //           lat: _currentPosition?.latitude.toString(),
                //           long: _currentPosition?.longitude.toString(),
                //           noHP: _controllerPhone.text.toString(),
                //         ));
                //     // logout();
                //   }
                // });
              },
              tooltip: 'DARURAT',
              backgroundColor: Colors.red,
              child: const Text(
                'SOS',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              ),
            )
            // child: DefaultText(
            //   textLabel: 'SOS',
            //   fontWeight: FontWeight.bold,
            //   colorsText: Colors.black,
            //   sizeText: 30,
            // )),
            ),
        body: Obx((() => Stack(
              children: [
                Image.asset(R.images_background_onboard),
                controller.getPageWidget(controller.pos.value)!
              ],
            ))))));
  }
}
