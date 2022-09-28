import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/config/env_config.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';
import 'package:new_movie_flutter/core/base/base_view.dart';
import 'package:new_movie_flutter/core/base/page_state.dart';
import 'package:new_movie_flutter/core/texts.dart';
import 'package:new_movie_flutter/data/model/res/res_category.dart';
import 'package:new_movie_flutter/data/model/res/res_informasi.dart';
import 'package:new_movie_flutter/network/dio_provider.dart';
import 'package:new_movie_flutter/r.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/screen/home/homescreen_controller.dart';
import 'package:new_movie_flutter/util/ext.dart';

class HomescreenView extends GetView<HomeController> {
  const HomescreenView({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  Widget _buildScreen() {
    Get.lazyPut<HomeController>(() => HomeController());
    return SafeArea(
      child: controller.isLoading.value == true
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: controller.reset,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: Stack(
                    children: [
                      Image.asset(R.images_background_onboard,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(Get.context!).size.width),
                      Column(
                        children: [
                          Stack(
                            children: [
                              Opacity(
                                  opacity: 0.7,
                                  child: Image.network(
                                      '${DioProvider.baseUrl}doc/banner/${controller.imageBanner.value}',
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: LinearProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  })),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(MyRouter.settingscreen);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: const Align(
                                      alignment: Alignment.topRight,
                                      child: Icon(
                                        Icons.settings,
                                        size: 30,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade200, width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                margin:
                                    const EdgeInsets.fromLTRB(20, 180, 20, 16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Selamat Datang, ${controller.name}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.cyan.shade700),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.notifications_active,
                                            color: Colors.cyan,
                                          ),
                                          onPressed: () {
                                            // do something
                                          },
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: Divider(
                                        color: Colors.grey.withOpacity(0.5),
                                        height: 1,
                                      ),
                                    ),
                                    const Text(
                                      'MENU KATEGORI',
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: getKategori(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 20, bottom: 10),
                            child: const Text('Tahukan Kamu ?'),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: getInfo(),
                            ),
                          ),
                          _menuSlide()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget content() {
    return Obx(() => _buildScreen());
  }

  Widget banner(String assets) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(MyRouter.detailimagescreen,
            arguments: {'urlImage': assets, 'isNet': false});
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(4, 8),
              ),
            ]),
        child: Image.asset(assets, fit: BoxFit.fill),
      ),
    );
  }

  Widget informasi(ResInfo info) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10, right: 10),
          width: 200,
          height: 200,
          padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
          decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(4, 8),
                ),
              ]),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(MyRouter.detailimagescreen, arguments: {
                'urlImage':
                    '${DioProvider.baseUrl}doc/informasi_bantuan/images/${info.namaFile}',
                'isNet': true
              });
            },
            child: Image.network(
                '${DioProvider.baseUrl}doc/informasi_bantuan/images/${info.namaFile}',
                width: 200,
                fit: BoxFit.cover),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          width: 200,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(4, 8),
                ),
              ]),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Text(
              info.informasiJudul ?? '',
              maxLines: 1,
              style: const TextStyle(
                fontSize: 15,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget menuKategori(ResCategory category) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(MyRouter.kategoriscreen, arguments: {
          'kategoriId': category.kategoriId.toString(),
          'kategoriJudul': category.kategoriNama.toString()
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.cyan.shade700,
          border: Border.all(color: Colors.grey.shade200, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                category.kategoriNama ?? '',
                style: whiteTextStyle,
                maxLines: 1,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getKategori() {
    List<Widget> list = [];
    controller.allCategory?.forEach((element) {
      list.add(menuKategori(element));
    });

    return list;
  }

  List<Widget> getInfo() {
    List<Widget> list = [];
    controller.allInformasi?.forEach((element) {
      list.add(informasi(element));
    });
    return list;
  }

  Widget _menuSlide() {
    return ImageSlideshow(
      width: double.infinity,
      height: 200,
      initialPage: 0,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.grey,
      onPageChanged: (value) {},
      autoPlayInterval: 4000,
      children: [banner(R.images_slide1), banner(R.images_slide2)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: content());
  }
}
