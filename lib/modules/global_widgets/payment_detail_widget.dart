import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/appointment_model.dart';
import 'appointment_row_widget.dart';

class PaymentDetailsWidget extends StatelessWidget {
  const PaymentDetailsWidget({
    super.key,
    required Appointment appointment,
  }) : _appointment = appointment;

  final Appointment _appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
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
              ),
            ],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Wrap(
              runSpacing: 6,
              alignment: WrapAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      _appointment.station?.name ?? '',
                      style: Get.textTheme.bodyMedium,
                      maxLines: 3,
                      // textAlign: TextAlign.end,
                    ),
                  ],
                ),
                Divider(
                  height: 2,
                  thickness: 1,
                  color: Get.theme.dividerColor,
                ),
                AppointmentRowWidget(
                  description: "Time".tr,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        _appointment.station?.availableDurations
                                ?.firstWhere((e) =>
                                    e['id'] == _appointment.duration)['duration'] ??
                            "",
                        style: Get.textTheme.titleMedium),
                  ),
                ),
                AppointmentRowWidget(
                  description: "Rate".tr,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        "\$${_appointment.station?.rate}/hr",
                        style: Get.textTheme.titleMedium),
                  ),
                ),
                AppointmentRowWidget(
                  description: "Total Amount".tr,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        "\$${_appointment.station!.rate! * (int.parse(_appointment.duration!)/ 60)}",
                        style: Get.textTheme.titleMedium),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
