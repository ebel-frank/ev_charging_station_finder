import 'package:ev_charging/models/appointment_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../providers/api_provider.dart';

class BookingRepository {
  late GetStorage _box;

  BookingRepository() {
    _box = GetStorage();
  }

  Future<List<Appointment>> getAllBookings() async {
    final bookings = (_box.read('bookings') as List?) ?? [];
    return bookings.map((e) => Appointment.fromJson(e)).toList();
  }

  Future<void> saveBooking(Appointment appointment) async {
    await Future.delayed(Duration(seconds: 2));
    final appointments = (_box.read('bookings') as List?) ?? [];
    appointments.add(appointment);
    _box.write('bookings', appointments.map((e) => e.toJson()).toList());
  }
}
