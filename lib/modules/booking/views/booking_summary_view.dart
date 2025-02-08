import 'package:ev_charging/modules/booking/controllers/booking_summary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/routes.dart';
import '../../../common/ui.dart';
import '../../../models/appointment_model.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/payment_detail_widget.dart';

class BookingSummaryView extends GetView<BookingSummaryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Summary", style: Get.textTheme.titleMedium,),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      bottomNavigationBar: buildBottomWidget(controller.appointment.value),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: Ui.getBoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Booking At".tr, style: Get.textTheme.bodyLarge),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        color: Get.theme.focusColor),
                    SizedBox(width: 15),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            DateFormat.yMMMMEEEEd(Get.locale.toString()).format(
                                controller.appointment.value.appointmentAt!),
                            style: Get.textTheme.bodyMedium),
                        Text(
                            DateFormat('HH:mm', Get.locale.toString()).format(
                                controller.appointment.value.appointmentAt!),
                            style: Get.textTheme.bodyMedium),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: Ui.getBoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Starting At".tr, style: Get.textTheme.bodyLarge),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        color: Get.theme.focusColor),
                    SizedBox(width: 15),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            DateFormat.yMMMMEEEEd(Get.locale.toString()).format(
                                controller.appointment.value.appointmentAt!),
                            style: Get.textTheme.bodyMedium),
                        Text(
                            DateFormat('HH:mm', Get.locale.toString())
                                .format(controller.appointment.value.startAt!),
                            style: Get.textTheme.bodyMedium),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: Ui.getBoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ending At".tr, style: Get.textTheme.bodyLarge),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        color: Get.theme.focusColor),
                    SizedBox(width: 15),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            DateFormat.yMMMMEEEEd(Get.locale.toString()).format(
                                controller.appointment.value.appointmentAt!),
                            style: Get.textTheme.bodyMedium),
                        Text(
                            DateFormat('HH:mm', Get.locale.toString())
                                .format(controller.appointment.value.endsAt!),
                            style: Get.textTheme.bodyMedium),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: Ui.getBoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Charging Time".tr, style: Get.textTheme.bodyLarge),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.timelapse_rounded, color: Get.theme.focusColor),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                          controller
                              .appointment.value.station?.availableDurations
                              ?.firstWhere((e) =>
                                  e['id'] ==
                                  controller
                                      .appointment.value.duration)['duration'],
                          style: Get.textTheme.bodyMedium),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
              text: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Confirm & Checkout".tr,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.titleMedium?.merge(
                        TextStyle(color: Get.theme.primaryColor),
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      color: Get.theme.primaryColor, size: 20)
                ],
              ),
              color: Get.theme.colorScheme.secondary,
              onPressed: () async {
                await Get.toNamed(AppRoutes.CHECKOUT, arguments: _appointment);
              }).paddingSymmetric(vertical: 10, horizontal: 20),
        ],
      ),
    );
  }
}
