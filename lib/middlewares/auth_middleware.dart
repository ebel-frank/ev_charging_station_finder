import 'package:ev_charging/common/routes.dart';
import 'package:ev_charging/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    if (!authService.isAuth) {
      return RouteSettings(name: AppRoutes.LOGIN);
    }
    return null;
  }
}