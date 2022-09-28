import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:new_movie_flutter/core/base/base_controller.dart';
import 'package:new_movie_flutter/core/base/base_response_model.dart';
import 'package:new_movie_flutter/data/model/res/res_cuaca.dart';
import 'package:new_movie_flutter/data/model/res/res_kapal.dart';
import 'package:new_movie_flutter/data/model/res/res_login.dart';
import 'package:new_movie_flutter/data/repository/private/private_repository.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/screen/cuaca/cuaca_view.dart';
import 'package:new_movie_flutter/screen/home/homescreen_view.dart';
import 'package:new_movie_flutter/util/ext.dart';
import 'package:new_movie_flutter/util/preferences.dart';
import 'package:toast/toast.dart';

import '../data/repository/public/public_repository.dart';

class MainScreenController extends BaseController {
  final PublicRepository _repositoryPublic =
      Get.find(tag: (PublicRepository).toString());
  final PrivateRepository _repositoryPrivate =
      Get.find(tag: (PrivateRepository).toString());

  var pos = 0.obs;
  var isLoading = false.obs;
  var selectedCard = 100.obs;
  var id = ''.obs;

  final TextEditingController controllerPhone = TextEditingController();

  List<ResKapal>? kapalModel = RxList();
  Rx<String> name = ''.obs;
  Rx<String> userId = ''.obs;
  Rx<String> token = ''.obs;
  Rx<String> tokenKey = ''.obs;

  Location location = Location();
  LocationData? currentPosition;

  late StreamSubscription<LocationData> locationSubscription;

  getData() async {
    name.value = await Preferences.getNama();
    userId.value = await Preferences.getUserId();
    token.value = await Preferences.getToken();
    tokenKey.value = await Preferences.getTokenKey();
    getKapalHome();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Widget? getPageWidget(int pos) {
    switch (pos) {
      case 0:
        return const HomescreenView();
      case 1:
        return const CuacaView();
      default:
        return const Center(
          child: Text(''),
        );
    }
  }

  void getKapalHome() {
    callDataService(
        _repositoryPrivate.getKapalHome(ResLogin(
            userId: int.parse(userId.value),
            token: token.value,
            tokenKey: tokenKey.value)),
        onStart: () => isLoading.value = true,
        onError: ((exceptio) => isLoading.value = false),
        onSuccess: _handleKapalHome);
  }

  showKapalListSheet(List<ResKapal>? kapalModel) {
    isLoading.value = false;
    return showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        ),
        context: Get.context!,
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Pilih Kapal',
                      style: TextStyle(
                        color: Colors.cyan.shade700,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey.withOpacity(0.5), height: 1),
                  isLoading.value == true
                      ? const LinearProgressIndicator(
                          backgroundColor: Colors.white, minHeight: 2)
                      : Expanded(
                          flex: 3,
                          child: SizedBox(
                            width: double.infinity,
                            child: GridView.builder(
                                shrinkWrap: false,
                                scrollDirection: Axis.vertical,
                                itemCount: kapalModel?.length,
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 100 / 100,
                                ),
                                itemBuilder: (BuildContext context, index) {
                                  ToastContext().init(context);

                                  return Obx((() => GestureDetector(
                                        onTap: () {
                                          selectedCard.value = index;
                                          id.value =
                                              kapalModel![index].kapalId!;
                                          print(id.value);
                                        },
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    image: const DecorationImage(
                                                        image: NetworkImage(
                                                            'https://vytautaslaisonas.files.wordpress.com/2011/10/100x100-scaled-1000.jpg?w=500&h=509&zoom=2'),
                                                        fit: BoxFit.fill),
                                                    border: Border.all(
                                                        color: selectedCard
                                                                    .value ==
                                                                index
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        width: 1),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10))),
                                              ),
                                              Container(
                                                height: 50,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: selectedCard
                                                                    .value ==
                                                                index
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                        width: 1),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Text(
                                                  '${kapalModel![index].namaKapal}',
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )));
                                }),
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: textField(Icons.phone, 'No. HP', controllerPhone,
                        TextInputType.phone, Colors.black),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          textColor: Colors.black,
                          color: Colors.white,
                          child: const Text(
                            'PILIH',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            if (controllerPhone.text.isEmpty) {
                              Toast.show('Masukan Nomor HP terlebih dahulu',
                                  gravity: Toast.bottom,
                                  duration: Toast.lengthShort);
                            } else {
                              Preferences.setKapalId(id.value);
                              setKapalHp(id.value);
                              // AppRouter.pop(context);
                              print(id.toString());
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  getLoc() async {
    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    currentPosition = await location.getLocation();
    locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) {
      print(currentLocation);
    });

    const oneSec = Duration(seconds: 10);
    Timer.periodic(oneSec, (Timer t) {
      Preferences.getKapalId().then((value) {
        setKapalLocation(value);
        print('set$value');
      });
    });
  }

  setKapalHp(String idKapal) {
    callDataService(
        _repositoryPrivate.setKapalPhone(
            idKapal.toString(),
            currentPosition!.longitude.toString(),
            currentPosition!.latitude.toString(),
            controllerPhone.value.text),
        onError: ((exception) => isLoading.value = false),
        onStart: () => isLoading.value = true,
        onSuccess: _handleSetKapalPhone);
  }

  setKapalLocation(String id) async {
    if (id.toString().isEmpty || id.toString() == 'null') {
      print(id);
      print('blm pilih kapal');
    } else {
      callDataService(
          _repositoryPrivate.setKapalLocation(
              id: id.toString(),
              long: currentPosition!.longitude.toString(),
              lat: currentPosition!.latitude.toString(),
              status: ''),
          onError: ((exception) => isLoading.value = false),
          onStart: () => isLoading.value = true,
          onSuccess: _handleSetKapalLocation);
    }
  }

  void _handleSetKapalPhone(BaseResponseModel response) {
    isLoading.value = false;
    Toast.show('Sukses', gravity: Toast.bottom, duration: Toast.lengthShort);
    Get.back();
  }

  void _handleKapalHome(BaseResponseModel response) async {
    isLoading.value = false;
    ToastContext().init(Get.context!);

    List list = jsonDecode(response.data!);
    kapalModel?.clear();
    for (var element in list) {
      kapalModel?.add(ResKapal.fromJson(element));
    }
    var valueId = await Preferences.getKapalId();
    if (valueId.isEmpty || valueId == 'null') {
      showKapalListSheet(kapalModel);
      update();
      if (kapalModel!.isEmpty) {
        Preferences().logout();

        Future.delayed(const Duration(seconds: 3)).then((value) {
          isLoading.value = false;
          showSnackbar('Maaf anda tidak memiliki kapal yang tersedia');
          Preferences.getUserId().then((value) => print(value));
          Get.offAllNamed(MyRouter.splashscreen);
        });
      }
    }
    getLoc();
  }

  void _handleSetKapalLocation(BaseResponseModel response) {}

  @override
  void dispose() {
    locationSubscription.cancel();
    super.dispose();
  }
}
