/*
 * Copyright (c) 2020 .
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ev_charging/modules/checkout/controllers/checkout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/payment_method_model.dart';

class PaymentMethodItemWidget extends GetView<CheckoutController> {
  const PaymentMethodItemWidget({
    required PaymentMethod paymentMethod,
  }) : _paymentMethod = paymentMethod;

  final PaymentMethod _paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: Ui.getBoxDecoration(),
        child: RadioListTile(
            value: _paymentMethod,
            groupValue: controller.selectedPaymentMethod.value,
            activeColor: Get.theme.colorScheme.secondary,
            onChanged: (PaymentMethod? value) {
              controller.selectPaymentMethod(value!);
            },
            title: Text(_paymentMethod.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: Get.textTheme.bodyMedium).paddingOnly(bottom: 5),
            subtitle: Text(_paymentMethod.description, style: Get.textTheme.bodySmall),
            secondary: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                imageUrl: _paymentMethod.logo,
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 60,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              ),
            )),
      );
    });
  }
}