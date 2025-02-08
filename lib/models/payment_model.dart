import 'package:get/get.dart';

import 'parents/model.dart';
import 'payment_method_model.dart';
import 'payment_status_model.dart';

class Payment extends Model {
  double? _amount;
  PaymentMethod? _paymentMethod;
  PaymentStatus? _paymentStatus;

  Payment({String? id, double? amount, PaymentMethod? paymentMethod, PaymentStatus? paymentStatus}) {
    this.id = id;
    _paymentStatus = paymentStatus;
    _paymentMethod = paymentMethod;
    _amount = amount;
  }

  Payment.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _amount = doubleFromJson(json, 'amount');
    _paymentMethod = objectFromJson(json, 'payment_method', (v) => PaymentMethod.fromJson(v));
    _paymentStatus = objectFromJson(json, 'payment_status', (v) => PaymentStatus.fromJson(v));
  }

  double get amount => _amount ?? 0;

  set amount(double? value) {
    _amount = value;
  }

  PaymentMethod get paymentMethod => _paymentMethod ?? PaymentMethod();

  set paymentMethod(PaymentMethod? value) {
    _paymentMethod = value;
  }

  PaymentStatus get paymentStatus => _paymentStatus ?? PaymentStatus(status: "Not Paid".tr);

  set paymentStatus(PaymentStatus? value) {
    _paymentStatus = value;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    if (paymentMethod.hasData) {
      data['payment_method'] = paymentMethod.toJson();
    }
    if (paymentStatus.hasData) {
      data['payment_status'] = paymentStatus.toJson();
    }
    return data;
  }
}