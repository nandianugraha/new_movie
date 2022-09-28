import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/binding/initial_binding.dart';
import 'package:new_movie_flutter/routes/my_router.dart';
import 'package:new_movie_flutter/util/preferences.dart';
import 'package:new_movie_flutter/widget/confirmation_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class NewAuthController extends GetxController {

  

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  var isLoading = false.obs;

  void asyncPermission() {
    _requestPermission().then((value) {
      if (value) {
        isLoading.value = false;
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
}
