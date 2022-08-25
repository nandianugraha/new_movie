import 'package:new_movie_flutter/data/model/upcoming_response.dart';

abstract class PublicRemoteDataSource {
  Future<Upcoming> getUpcomingService(String type);
}
