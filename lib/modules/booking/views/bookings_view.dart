import 'package:cached_network_image/cached_network_image.dart';
import 'package:ev_charging/modules/booking/controllers/bookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/assets.dart';
import '../../global_widgets/appointment_row_widget.dart';

class BookingsView extends GetView<BookingsController> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.refreshBookings(isRefresh: true);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: Text("My Bookings"),
                automaticallyImplyLeading: false,
                leadingWidth: 0,
              ),
              Obx(() {
                if (controller.isLoading.isTrue) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.appointments.isEmpty) {
                  return SizedBox(
                    height: Get.height * 0.7,
                    child: Center(
                      child: Text("No Bookings found"),
                    ),
                  );
                }
                  return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.appointments.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final _appointment = controller.appointments.elementAt(index);
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CachedNetworkImage(
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                    imageUrl: _appointment.station!.images![0],
                                    placeholder: (context, url) => Image.asset(
                                      'assets/img/loading.gif',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 80,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error_outline),
                                  ),
                                  Container(
                                    width: 80,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    color: Assets.primaryColor.withOpacity(0.2),
                                    child: Text("${_appointment.payment?.paymentStatus.status}", textAlign: TextAlign.center,),
                                  )
                                ],
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Wrap(
                                  runSpacing: 4,
                                  alignment: WrapAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text(
                                          _appointment.station?.name ?? '',
                                          style: Get.textTheme.bodyMedium,
                                          maxLines: 2,
                                          // textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_pin, color: Colors.grey, size: 20,),
                                        SizedBox(width: 8,),
                                        Text(_appointment.station?.address ?? '', style: Get.textTheme.bodySmall,)
                                      ],
                                    ),
                                    Divider(
                                      height: 2,
                                      thickness: 1,
                                      color: Get.theme.dividerColor,
                                    ),
                                    AppointmentRowWidget(
                                      description: "Starts At".tr,
                                      descriptionFlex: 1,
                                      valueFlex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(DateFormat.MMMEd(Get.locale.toString()).add_Hm().format(
                                            _appointment.startAt!),
                                            textAlign: TextAlign.end,
                                            style: Get.textTheme.bodyMedium),
                                      ),
                                    ),
                                    AppointmentRowWidget(
                                      description: "Duration".tr,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                            _appointment.station?.availableDurations
                                                    ?.firstWhere((e) =>
                                                        e['id'] ==
                                                        _appointment
                                                            .duration)['duration'] ??
                                                "",
                                            style: Get.textTheme.bodyMedium),
                                      ),
                                    ),
                                    AppointmentRowWidget(
                                      description: "Total Amount".tr,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                            "\$${_appointment.station!.rate! * (int.parse(_appointment.duration!) / 60)}",
                                            style: Get.textTheme.bodyMedium),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                  separatorBuilder: (context, index) => Divider(),);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
