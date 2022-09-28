import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/screen/sos/sos_controller.dart';

class SosView extends GetView<SosController> {
  const SosView({Key? key}) : super(key: key);

  Widget _buildScreen() {
    return controller.isLoading.value == true
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      top: 100, left: 30, right: 30, bottom: 30),
                  child: const Text(
                      'Mohon Untuk menggunakan tombol darurat SOS dengan bijak',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(fontSize: 20, color: Colors.white))),
              GestureDetector(
                onLongPress: () {
                  controller.sendSOS();
                },
                child: Center(
                  child: Container(
                      padding: const EdgeInsets.all(50),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.red.shade700,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ], color: Colors.red, shape: BoxShape.circle),
                      child: const Icon(Icons.power_settings_new, size: 50)),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: 50, left: 30, right: 30, bottom: 30),
                  child: const Text(
                      'Catatan:\nSilahkan tekan lama untuk mengirimkan sinyal darurat SOS',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(fontSize: 10, color: Colors.white))),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.2),
          appBar: AppBar(
            backgroundColor: Colors.grey.withOpacity(0.2),
            title: const Text('SOS'),
            leading: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back_ios)),
          ),
          body: _buildScreen(),
        ));
  }
}
