import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:new_movie_flutter/r.dart';
import 'package:new_movie_flutter/screen/cuaca/cuaca_controller.dart';
import 'package:new_movie_flutter/util/ext.dart';

class CuacaView extends GetView<CuacaController> {
  const CuacaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CuacaController>(() => CuacaController());
    return Scaffold(
      body: SafeArea(
        child: controller.isLoading.value == true
            ? const LinearProgressIndicator(
                minHeight: 2,
              )
            : RefreshIndicator(
                onRefresh: controller.reset,
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Obx((() => Stack(
                          children: [
                            Image.asset(R.images_background_onboard,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width),
                            Column(children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      controller.weather?.name ?? '-',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Text(formatToDateTimeString(
                                        DateTime.now(),
                                        format: 'EEEE, dd MMMM yyyy')),
                                  ),
                                  Image.asset(
                                      controller.condition(controller
                                          .listData![controller.pos.value]
                                          .weather),
                                      width: 150,
                                      height: 150),
                                  Text(
                                    '${controller.listData![controller.pos.value].weather}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    '${controller.listData![controller.pos.value].timeDesc}',
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50,
                                        right: 50,
                                        top: 10,
                                        bottom: 10),
                                    child: Divider(
                                      height: 1,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 50, right: 50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${controller.listData![controller.pos.value].waveCat}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Icon(Icons.waves)
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 50,
                                        right: 50,
                                        top: 10,
                                        bottom: 10),
                                    child: Divider(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 50, right: 50),
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Ketinggian Gelombang : ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: controller
                                                  .listData![
                                                      controller.pos.value]
                                                  .waveDesc,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 50, right: 50),
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Angin Dari ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  '${controller.listData![controller.pos.value].windFrom} ',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          const TextSpan(text: 'ke '),
                                          TextSpan(
                                              text:
                                                  '${controller.listData![controller.pos.value].windTo}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 50, right: 50),
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Kecepatan Angin : ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  '${controller.listData![controller.pos.value].windSpeedMin} - ${controller.listData![controller.pos.value].windSpeedMax} Km/j',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 50, right: 50, top: 100),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.pos.value = 0 + 1;
                                          },
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                  controller.condition(
                                                      controller.listData![1]
                                                          .weather),
                                                  width: 50,
                                                  height: 50),
                                              Text(
                                                '${controller.listData?[1].weather}',
                                              ),
                                              Text(
                                                '${controller.listData?[1].timeDesc}',
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // pos = 0 + 2;
                                            // print([0 + 2]);
                                            if (controller
                                                    .listData?[2].weather ==
                                                null) {
                                              showSnackbar(
                                                  'Data tidak tersedia');
                                            } else {
                                              controller.pos.value = 0 + 2;
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              controller.listData?[2].weather ==
                                                      null
                                                  ? const Icon(
                                                      Icons
                                                          .not_interested_sharp,
                                                      size: 50,
                                                    )
                                                  : Image.asset(
                                                      controller.condition(
                                                          controller
                                                              .listData?[2]
                                                              .weather),
                                                      width: 50,
                                                      height: 50),
                                              Text(
                                                  '${controller.listData?[2].weather}'),
                                              Text(
                                                  '${controller.listData?[2].timeDesc}')
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // pos = 0 + 3;
                                            // print([0 + 3]);
                                            if (controller
                                                    .listData?[3].weather ==
                                                null) {
                                              showSnackbar(
                                                  'Data tidak tersedia');
                                            } else {
                                              controller.pos.value = 0 + 3;
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              controller.listData?[2].weather ==
                                                      null
                                                  ? const Icon(
                                                      Icons
                                                          .not_interested_sharp,
                                                      size: 50,
                                                    )
                                                  : Image.asset(
                                                      controller.condition(
                                                          controller
                                                              .listData?[3]
                                                              .weather),
                                                      width: 50,
                                                      height: 50),
                                              Text(
                                                  '${controller.listData?[3].weather}'),
                                              Text(
                                                  '${controller.listData?[3].timeDesc}')
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ]),
                          ],
                        )))),
              ),
      ),
    );
  }
}
