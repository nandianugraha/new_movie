import 'package:get/get.dart';
import 'package:new_movie_flutter/data/model/upcoming_response.dart';
import 'package:new_movie_flutter/data/remote/public_remote_data_source.dart';
import 'package:new_movie_flutter/data/repository/public_repository.dart';

class PublicRepositoryImpl implements PublicRepository {
  final PublicRemoteDataSource _remoteSource =
      Get.find(tag: (PublicRemoteDataSource).toString());

  @override
  Future<Upcoming> getUpcoming(String type) {
    return _remoteSource.getUpcomingService(type);
  }
}
