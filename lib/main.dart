import 'package:ev_charging/providers/api_provider.dart';
import 'package:ev_charging/services/auth_service.dart';
import 'package:ev_charging/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'common/routes.dart';

void main() async{
  await initServices();

  runApp(GetMaterialApp(
    title: Get.find<SettingsService>().appName ?? '',
    builder: FToastBuilder(),
    initialRoute: AppRoutes.INITIAL,
    debugShowCheckedModeBanner: false,
    locale: Locale('en', 'US'),
    defaultTransition: Transition.cupertino,
    theme: Get.find<SettingsService>().getTheme(),
    getPages: AppRoutes.routes,
  ));
}

Future<void> initServices() async {
  // await dotenv.load(fileName: ".env");
  // MapboxOptions.setAccessToken(dotenv.get('ACCESS_TOKEN'));
  await GetStorage.init();
  await Get.putAsync(() => ApiClient().init());
  await Get.putAsync(() => SettingsService().init());
  await Get.putAsync(() => AuthService().init());
}
