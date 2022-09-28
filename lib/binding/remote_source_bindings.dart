import 'package:get/get.dart';
import 'package:new_movie_flutter/data/remote/private/private_remote_data_source.dart';
import 'package:new_movie_flutter/data/remote/private/private_remote_data_source_impl.dart';
import 'package:new_movie_flutter/data/remote/public/public_remote_data_source.dart';
import 'package:new_movie_flutter/data/remote/public/public_remote_data_source_impl.dart';

class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublicRemoteDataSource>(
      () => PublicRemoteDataSourceImpl(),
      tag: (PublicRemoteDataSource).toString(),
      fenix: true
    );
    Get.lazyPut<PrivateRemoteDataSource>(
      () => PrivateRemoteDataSourceImpl(),
      tag: (PrivateRemoteDataSource).toString(),
      fenix: true
    );
  }
}
