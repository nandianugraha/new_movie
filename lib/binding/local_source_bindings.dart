import 'package:get/get.dart';
import 'package:new_movie_flutter/data/local/preference/preference_manager.dart';
import 'package:new_movie_flutter/data/local/preference/preference_manager_impl.dart';

class LocalSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreferenceManager>(
      () => PreferenceManagerImpl(),
      tag: (PreferenceManager).toString(),
      fenix: true,
    );
  }
}
