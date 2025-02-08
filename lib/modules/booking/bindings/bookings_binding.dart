import 'package:get/get.dart';

import '../controllers/booking_summary_controller.dart';
import '../controllers/bookings_controller.dart';

class BookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingSummaryController>(
          () => BookingSummaryController(),
    );
  }
}
