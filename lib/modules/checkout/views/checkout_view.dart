import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/appointment_model.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/payment_detail_widget.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/payment_method_item_widget.dart';

class CheckoutView extends GetView<CheckoutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout".tr,
          style: context.textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.loadPaymentMethodsList();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Obx(() {
            if (controller.isLoadingPaymentMethods.isTrue) {
              return CircularLoadingWidget(height: 200);
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    leading: Icon(
                      Icons.payment,
                      color: Get.theme.hintColor,
                    ),
                    title: Text(
                      "Payment Option".tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.titleLarge,
                    ),
                    subtitle: Text("Select your preferred payment mode".tr,
                        style: Get.textTheme.bodySmall),
                  ),
                ),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.paymentsList.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    var paymentMethod =
                        controller.paymentsList.elementAt(index);
                    return PaymentMethodItemWidget(
                        paymentMethod: paymentMethod);
                  },
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: buildBottomWidget(Get.arguments as Appointment),
    );
  }

  Widget buildBottomWidget(Appointment _appointment) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Get.theme.focusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PaymentDetailsWidget(appointment: _appointment),
          BlockButtonWidget(
              text: Obx(() {
                return Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: controller.isLoading.value
                          ? Center(
                            child: SizedBox.square(
                                dimension: 20,
                                child: CircularProgressIndicator(
                                    color: Get.theme.primaryColor,
                                    strokeWidth: 3)),
                          )
                          : Text(
                              "Confirm & Pay Now".tr,
                              textAlign: TextAlign.center,
                              style: Get.textTheme.titleMedium?.merge(
                                TextStyle(color: Get.theme.primaryColor),
                              ),
                            ),
                    ),
                    controller.isLoading.value
                        ? SizedBox.shrink()
                        : Icon(Icons.arrow_forward_ios,
                            color: Get.theme.primaryColor, size: 20)
                  ],
                );
              }),
              color: Get.theme.colorScheme.secondary,
              onPressed: () {
                controller.payAppointment(_appointment);
              }).paddingSymmetric(vertical: 10, horizontal: 20),
        ],
      ),
    );
  }
}
