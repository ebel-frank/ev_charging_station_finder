import 'package:ev_charging/models/appointment_model.dart';
import 'package:ev_charging/repositories/booking_repository.dart';
import 'package:get/get.dart';

import '../../../common/ui.dart';

class BookingsController extends GetxController {
  final isLoading = false.obs;
  final appointments = <Appointment>[].obs;
  late BookingRepository _bookingRepository;

  BookingsController() {
    _bookingRepository = BookingRepository();
  }

  @override
  void onInit() {
    super.onInit();
    getBookings();
  }

  void refreshBookings({bool isRefresh = false}) async {
    await getBookings();
    if (isRefresh) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Bookings refreshed successfully"));
    }
  }

  Future<void> getBookings() async {
    isLoading.value = true;
    try {
      appointments.clear();
      appointments.addAll(await _bookingRepository.getAllBookings());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoading.value = false;
    }
  }
}
