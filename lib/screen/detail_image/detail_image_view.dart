import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/screen/detail_image/detail_image_controller.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class DetailImageView extends GetView<DetailImageController> {
  const DetailImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((() => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.grey.withOpacity(0.2),
            leading: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back_ios)),
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: PinchZoom(
              resetDuration: const Duration(milliseconds: 100),
              maxScale: 5,
              zoomEnabled: true,
              child: controller.isNet.value == true
                  ? Image.network(controller.urlImage.value)
                  : Image.asset(controller.urlImage.value),
            ),
          ),
        )));
  }
}
