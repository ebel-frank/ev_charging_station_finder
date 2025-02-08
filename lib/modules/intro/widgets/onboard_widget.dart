import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OnboardWidget extends StatelessWidget {
  final Widget title;
  final String description;
  final String asset;

  final int pageIndex;
  final double currentPage;
  final double parallaxRatio = 0.5;

  const OnboardWidget(
      {super.key,
        required this.title,
        required this.description,
        required this.asset,
        required this.pageIndex,
        required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: SvgPicture.asset(asset),
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        title.paddingSymmetric(horizontal: 20),
        const SizedBox(height: 16),
        Text(description,
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyMedium?.copyWith(fontSize: 13)).paddingSymmetric(horizontal: 20),
      ],
    );
  }
}