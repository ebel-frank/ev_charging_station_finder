import 'package:ev_charging/common/routes.dart';
import 'package:ev_charging/models/payment_status_model.dart';
import 'package:ev_charging/repositories/booking_repository.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/appointment_model.dart';
import '../../../models/payment_method_model.dart';
import '../../../models/payment_model.dart';
import '../../../repositories/payment_repository.dart';

class CheckoutController extends GetxController {
  late PaymentRepository _paymentRepository;
  late BookingRepository _bookingRepository;
  final paymentsList = <PaymentMethod>[].obs;
  final isLoadingPaymentMethods = true.obs;
  final isLoading = false.obs;
  final appointment = Appointment().obs;
  Rx<PaymentMethod> selectedPaymentMethod = PaymentMethod().obs;

  final hasPaid = false.obs;

  CheckoutController() {
    _paymentRepository = PaymentRepository();
    _bookingRepository = BookingRepository();
  }

  @override
  void onInit() async {
    appointment.value = Get.arguments as Appointment;
    await loadPaymentMethodsList();
    super.onInit();
  }

  Future loadPaymentMethodsList() async {
    try {
      paymentsList.assignAll(await _paymentRepository.getMethods());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoadingPaymentMethods.value = false;
    }
  }

  void selectPaymentMethod(PaymentMethod paymentMethod) {
    selectedPaymentMethod.value = paymentMethod;
  }

  Future<void> payAppointment(Appointment _appointment) async {
    if (!selectedPaymentMethod.value.hasData) {
      Get.showSnackbar(
        Ui.ErrorSnackBar(message: "Please select a payment method".tr),
      );
      return;
    }
    isLoading.value = true;
    try {
      _appointment.payment =
          Payment(
              paymentMethod: selectedPaymentMethod.value,
              amount: (_appointment.station!.rate! * (int.parse(_appointment.duration!)/ 60)),
              paymentStatus: PaymentStatus(id: "0", status: "Paid")
          );
      await _bookingRepository.saveBooking(_appointment);
      Get.toNamed(AppRoutes.FINAL_CHECKOUT);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      hasPaid.value = true;
      isLoading.value = false;
    }
  }

  bool isDone() {
    return hasPaid.value;
  }
}
