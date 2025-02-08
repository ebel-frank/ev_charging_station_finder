import 'package:ev_charging/models/payment_method_model.dart';
import 'package:ev_charging/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PaymentRepository {
  late ApiClient _apiClient;
  late GetStorage _box;

  PaymentRepository() {
    _apiClient = Get.find<ApiClient>();
    _box = GetStorage();
  }

  Future<List<PaymentMethod>> getMethods() {
    return _apiClient.getPaymentMethods();
  }
}