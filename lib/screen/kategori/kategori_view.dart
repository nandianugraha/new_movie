import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/network/dio_provider.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/screen/kategori/kategori_controller.dart';

class KategoriView extends GetView<KategoriController> {
  const KategoriView({Key? key}) : super(key: key);

  Widget _buildScreen() {
    return controller.isLoading.value == true
        ? const LinearProgressIndicator(color: Colors.cyan, minHeight: 2)
        : SafeArea(
            child: controller.resInfo.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.not_interested_sharp,
                          size: 150, color: Colors.cyan),
                      Text('Tidak Ada Data')
                    ],
                  ))
                : GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(controller.resInfo.length, (index) {
                      return Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              // border: Border.all(color: Colors.grey.withOpacity(0.5)),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
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
                                Get.toNamed(MyRouter.detailimagescreen,
                                    arguments: {
                                      'urlImage':
                                          '${DioProvider.baseUrl}doc/informasi_bantuan/images/${controller.resInfo[index].namaFile}',
                                      'isNet': true
                                    });
                              },
                              // child: Icon(Icons.image),
                              child: Image.network(
                                  '${DioProvider.baseUrl}doc/informasi_bantuan/images/${controller.resInfo[index].namaFile}',
                                  width: 200,
                                  fit: BoxFit.cover)));
                    }),
                  ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            leading: InkWell(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
            title: Text(controller.kategoriJudul.value,
                style: const TextStyle(color: Colors.black))),
        body: _buildScreen()));
  }
}
