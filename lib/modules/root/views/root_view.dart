import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/assets.dart';
import '../../global_widgets/custom_bottom_nav_bar.dart';
import '../../global_widgets/main_drawer_widget.dart';
import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
            return Scaffold(
              drawer: MainDrawerWidget(),
              body: controller.currentPage,
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: context.theme.scaffoldBackgroundColor,
                currentIndex: controller.currentIndex.value,
                selectedItemColor: Assets.primaryColor,
                onTap: (index) {
                  controller.changePage(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: "Home".tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.calendar),
                    label: "Bookings".tr,
                  ),
                ],
              ),
            );
          });
  }
}
