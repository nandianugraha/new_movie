import 'package:dio/dio.dart';
import 'package:new_movie_flutter/core/base/base_remote_service.dart';
import 'package:new_movie_flutter/data/model/upcoming_response.dart';
import 'package:new_movie_flutter/data/remote/public_remote_data_source.dart';
import 'package:new_movie_flutter/network/dio_provider.dart';
import 'package:new_movie_flutter/util/constant.dart';

class PublicRemoteDataSourceImpl extends BaseRemoteService
    implements PublicRemoteDataSource {
  String apikey = apiKeyV3;

  @override
  Future<Upcoming> getUpcomingService(String type) async {
    var endpoint = "${DioProvider.baseUrl}$type/popular?api_key=$apikey";
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseUpcomingResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  Upcoming _parseUpcomingResponse(Response<dynamic> response) {
    return Upcoming.fromJson(response.data);
  }
}
