import 'package:ev_charging/models/appointment_model.dart';
import 'package:get/get.dart';

class BookingSummaryController extends GetxController {
  final appointment = Appointment().obs;

  @override
  void onInit() {
    appointment.value = Get.arguments as Appointment;
    super.onInit();
  }

  void refreshBookings({bool useCache = true}) {

  }

  void createAppointment() {

  }

}