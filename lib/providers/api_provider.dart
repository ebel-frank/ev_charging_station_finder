import 'dart:convert';

import 'package:ev_charging/models/payment_method_model.dart';
import 'package:ev_charging/models/user_model.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/station_model.dart';

class ApiClient {
  Future<ApiClient> init() async {
    return this;
  }

  Future<List<Station>> getNearByStations() async {
    try {
      final data = json.decode(
        await rootBundle.loadString('assets/json/stations.json'),
      ) as List;
      return data.map((e) => Station.fromJson(e)).toList();
    } catch (e) {
      throw "An error occurred while fetching stations";
    }
  }

  Future<List> getStationAvailabilityHours(
      id, String duration, DateTime dateTime) async {
    try {
      final data = json.decode(
        await rootBundle.loadString('assets/json/availability$duration.json'),
      ) as List;
      return data;
    } catch (e) {
      throw "An error occurred while fetching availability hours";
    }
  }

  Future<List<PaymentMethod>> getPaymentMethods() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final data = json.decode(
        await rootBundle.loadString('assets/json/payment_methods.json'),
      ) as List;
      return data.map((e) => PaymentMethod.fromJson(e)).toList();
    } catch (e) {
      throw "An error occurred while fetching payment methods";
    }
  }
}
