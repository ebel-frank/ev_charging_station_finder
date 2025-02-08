import 'package:get/get.dart';

import '../../booking/controllers/bookings_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(
      () => RootController(),
    );
    Get.put(HomeController(), permanent: true);
    Get.put(BookingsController(), permanent: true);
  }
}
