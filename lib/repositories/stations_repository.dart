import 'package:ev_charging/providers/api_provider.dart';
import 'package:get/get.dart';

import '../models/station_model.dart';
import '../models/user_model.dart';

class StationsRepository {
  late ApiClient _apiClient;

  StationsRepository() {
    _apiClient = Get.find<ApiClient>();
  }

  Future<List<Station>> getNearByStations() {
    return _apiClient.getNearByStations();
  }

  Future<List> getAvailabilityHours(String id, String duration, DateTime dateTime) {
    return _apiClient.getStationAvailabilityHours(id, duration, dateTime);
  }

}
