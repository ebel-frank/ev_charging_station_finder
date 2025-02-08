import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget(
      {super.key,
      required this.color,
      required this.text,
      required this.onPressed,
      this.width});

  final Color? color;
  final Widget? text;
  final VoidCallback? onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: onPressed != null
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: color!.withOpacity(0.3),
                    blurRadius: 40,
                    offset: Offset(0, 15)),
              ],
            )
          : null,
      child: MaterialButton(
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        color: color,
        disabledElevation: 0,
        disabledColor: Colors.grey.withOpacity(0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        child: text,
      ),
    );
  }
}
