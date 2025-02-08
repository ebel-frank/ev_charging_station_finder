import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentRowWidget extends StatelessWidget {
  const AppointmentRowWidget({
    super.key,
    required this.description,
    this.value,
    this.valueStyle,
    this.hasDivider,
    required this.child,
    this.descriptionFlex,
    this.valueFlex,
  });

  final String? description;
  final int? descriptionFlex;
  final int? valueFlex;
  final String? value;
  final Widget child;
  final TextStyle? valueStyle;
  final bool? hasDivider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: descriptionFlex ?? 1,
          child: Text(
            description ?? "",
            style: Get.textTheme.bodyMedium,
          ),
        ),
        Expanded(
            flex: valueFlex ?? 1,
            child: child,)
      ],
    );
  }
}