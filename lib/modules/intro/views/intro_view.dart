import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../common/assets.dart';
import '../../global_widgets/block_button_widget.dart';
import '../controllers/intro_controller.dart';
import '../widgets/onboard_widget.dart';

class IntroView extends GetView<IntroController> {
  IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: PageView(
              physics: const BouncingScrollPhysics(),
              onPageChanged: (page) {
                debugPrint("onPageChanged: $page");
                controller.currentPage.value = page;
              },
              children: [
                Obx(() {
                  return OnboardWidget(
                      title: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Assets.primaryColor),
                              text: "Find",
                              children: [
                                TextSpan(
                                    style: TextStyle(
                                        color: Colors.black),
                                    text: " Your Nearest EV Charging Spot Effortlessly")
                              ])),
                      description:
                          "Locate the closest charging stations with real-time maps and directions.",
                      asset: Assets.locate,
                      pageIndex: 1,
                      currentPage: controller.currentPageValue.value);
                }),
                Obx(() {
                  return OnboardWidget(
                      title: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.black),
                              text: "Check EV Charging Station ",
                              children: [
                                TextSpan(
                                    style: TextStyle(
                                        color:Assets.primaryColor),
                                    text: "Availability"),
                                TextSpan(
                                    text: " Instantly")
                              ])),
                      description:
                          "See which stations are free or in use before you arrive.",
                      asset: Assets.availability,
                      pageIndex: 1,
                      currentPage: controller.currentPageValue.value);
                }),
                Obx(() {
                  return OnboardWidget(
                      title: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Assets.primaryColor),
                              text: "Reserve",
                              children: [
                                TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    text: " Your EV Charging Slot in Seconds")
                              ])),
                      description:
                          "Book a spot in advance and never wait in line again.",
                      asset: Assets.appointment,
                      pageIndex: 2,
                      currentPage: controller.currentPageValue.value);
                })
              ],
            )),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    3, // 3 intro pages
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 70, horizontal: 4),
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor:
                                controller.currentPage.value == index
                                    ? Assets.primaryColor
                                    : Colors.grey,
                          ),
                        )),
              );
            }),
            BlockButtonWidget(
                width: double.infinity,
                text: Text(
                  "Get Started".tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.titleMedium?.merge(
                    TextStyle(color: Get.theme.primaryColor),
                  ),
                ),
                color: Assets.primaryColor,
                onPressed: () async {
                  controller.getStarted();
                }).paddingSymmetric(horizontal: 20, vertical: 16),
          ],
        ),
      ),
    );
  }
}
