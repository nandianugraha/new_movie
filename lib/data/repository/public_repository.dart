import 'package:new_movie_flutter/data/model/upcoming_response.dart';

abstract class PublicRepository {
  Future<Upcoming> getUpcoming(String type);
}
