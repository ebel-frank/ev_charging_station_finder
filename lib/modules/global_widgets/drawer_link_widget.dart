import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/assets.dart';

class DrawerLinkWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final ValueChanged<void> onTap;

  const DrawerLinkWidget(
      {super.key,
        required this.icon,
        required this.text,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap('');
      },
      child: Container(
        padding:
        const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black54
            ),
            Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  width: 1,
                  height: 24,
                  color: Colors.black26,
                ),
            Expanded(
              child: Text(text.tr,
                  style: Get.textTheme.bodyMedium?.merge(TextStyle(
                      fontSize: 14,))),
            )
          ],
        ),
      ),
    );
  }
}