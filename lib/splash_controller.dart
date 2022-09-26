import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/splash_page.dart';
import 'package:new_movie_flutter/util/preferences.dart';
import 'package:new_movie_flutter/widget/confirmation_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool isLoading = false;

  @override
  void onInit() {
    animationInitilization();
    super.onInit();
  }

  animationInitilization() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => update());
    animationController.forward();
    animationController.addListener(() {
      if (animation.isCompleted) _goRouter();
    });
  }

  void asyncPermission() {
    _requestPermission().then((value) {
      if (value) {
        isLoading = false;
        // Future.delayed(Duration(seconds: 2)).then((value) {
        //   _goRouter();
        // });
        // _asyncSession();
      } else {
        // isLoading = false;

        Get.dialog(
          ConfirmationDialog(
              title: 'Sorry',
              description:
                  'Sintren Indramayu need access permissions to run normally.\nTo fix this? Please do uninstall and re-install again and make sure you have click YES/Allow to all permissions.',
              negatifText: 'CANCEL',
              positifText: 'OK',
              onPressed: () => asyncPermission()),
        );
        //     ShowDialog(
        //             context: context,
        //             message: "Sorry, " +
        //                 'Sintren Indramayu' +
        //                 " need access permissions to run normally.\nTo fix this? Please do uninstall and re-install again and make sure you have click YES/Allow to all permissions.")
        //         .titleNo("CANCEL")
        //         .titleYes("OK")
        //         .onNoPressed(() {
        //       SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        //     }).onYesPressed(() {
        //       asyncPermission();
        //     }).show();
        //   }
        // });
      }
    });
  }

  Future<bool> _requestPermission() async {
    List<Permission> permissions;
    if (Platform.isAndroid) {
      permissions = <Permission>[
        Permission.camera,
        Permission.photos,
        Permission.storage,
        // Permission.mediaLibrary,
        Permission.location,
      ];
    } else {
      permissions = <Permission>[
        Permission.camera,
        Permission.photos,
        Permission.storage,
        // Permission.mediaLibrary,
        Permission.location
      ];
    }
    final Map<Permission, PermissionStatus> permissionRequestResult =
        await permissions.request();

    List<Permission> permissionDenied = <Permission>[];
    permissionRequestResult.forEach((permissionsGroup, permissionStatus) => {
          if (permissionStatus == PermissionStatus.denied)
            {permissionDenied.add(permissionsGroup)}
        });

    return true;
  }

  // void goHome() => Get.offNamed(MyRouter.homepage);
  void _goRouter() {
    Preferences.getToken().then((value) {
      if (value.isEmpty || value == 'null') {
        isLoading = false;
      } else {
        // AppRouter.makeFirst(context, MainScreen());
        Get.offNamed(MyRouter.mainscreen);
      }
    });
  }
}
