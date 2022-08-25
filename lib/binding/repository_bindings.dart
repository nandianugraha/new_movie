import 'package:get/get.dart';
import 'package:new_movie_flutter/data/repository/public_repository.dart';
import 'package:new_movie_flutter/data/repository/public_repository_impl.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublicRepository>(
      () => PublicRepositoryImpl(),
      tag: (PublicRepository).toString(),
    );
  }
}
