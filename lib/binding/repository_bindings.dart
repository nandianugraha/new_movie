import 'package:get/get.dart';
import 'package:new_movie_flutter/data/repository/private/private_repository_impl.dart';
import 'package:new_movie_flutter/data/repository/private/private_repository.dart';
import 'package:new_movie_flutter/data/repository/public/public_repository.dart';
import 'package:new_movie_flutter/data/repository/public/public_repository_impl.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivateRepository>(
      () => PrivateRepositoryImpl(),
      tag: (PrivateRepository).toString(),
      fenix: true
    );
    Get.lazyPut<PublicRepository>(
      () => PublicRepositoryImpl(),
      tag: (PublicRepository).toString(),
      fenix: true
    );
  }
}
