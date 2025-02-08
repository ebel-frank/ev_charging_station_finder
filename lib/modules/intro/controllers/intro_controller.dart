import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../common/routes.dart';


class IntroController extends GetxController {
  final currentPage = 0.obs;
  final currentPageValue = 0.0.obs;

  IntroController() {}

  @override
  void onInit() {
    super.onInit();
  }


  void getStarted() {
    Get.offAndToNamed(AppRoutes.ROOT);
  }
}
