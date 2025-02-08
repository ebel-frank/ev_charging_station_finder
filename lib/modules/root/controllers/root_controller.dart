/*
 * Copyright (c) 2020 .
 */

import 'package:ev_charging/modules/booking/controllers/bookings_controller.dart';
import 'package:ev_charging/modules/booking/views/bookings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/routes.dart';
import '../../../services/auth_service.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/home_view.dart';

class RootController extends GetxController {
  final currentIndex = 0.obs;
  final notificationsCount = 0.obs;
  // late NotificationRepository _notificationRepository;

  RootController() {
    // _notificationRepository = new NotificationRepository();
  }

  @override
  void onInit() async {
    super.onInit();
    // await Get.find<AuthService>().getEmergencyRequestStatus();
  }

  List<Widget> pages = [
    HomeView(),
    BookingsView(),
  ];

  Widget get currentPage => pages[currentIndex.value];

  Future<void> changePageInRoot(int _index) async {
    if (!Get.find<AuthService>().isAuth && _index > 0) {
      await Get.toNamed(AppRoutes.LOGIN);
    } else {
      currentIndex.value = _index;
      await refreshPage(_index);
    }
  }

  Future<void> changePageOutRoot(int _index) async {
    if (!Get.find<AuthService>().isAuth && _index > 0) {
      await Get.toNamed(AppRoutes.LOGIN);
    }
    currentIndex.value = _index;
    await refreshPage(_index);
    await Get.offNamedUntil(AppRoutes.ROOT, (Route route) {
      if (route.settings.name == AppRoutes.ROOT) {
        return true;
      }
      return false;
    }, arguments: _index);
  }

  Future<void> changePage(int _index) async {
    if (Get.currentRoute == AppRoutes.ROOT) {
      await changePageInRoot(_index);
    } else {
      await changePageOutRoot(_index);
    }
  }

  Future<void> refreshPage(int _index) async {
    switch (_index) {
      case 0:
        Get.find<HomeController>().refreshHome();
        break;
      case 1:
        Get.find<BookingsController>().refreshBookings();
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
