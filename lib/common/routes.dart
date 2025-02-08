import 'package:ev_charging/modules/auth/bindings/auth_binding.dart';
import 'package:ev_charging/modules/auth/views/login_view.dart';
import 'package:ev_charging/modules/auth/views/register_view.dart';
import 'package:ev_charging/modules/booking/views/booking_summary_view.dart';
import 'package:ev_charging/modules/checkout/views/checkout_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../middlewares/auth_middleware.dart';
import '../modules/booking/bindings/bookings_binding.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/final_checkout_view.dart';
import '../modules/intro/bindings/intro_binding.dart';
import '../modules/intro/views/intro_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';

class AppRoutes {
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const ROOT = '/root';
  static const INTRO = '/intro';

  static const BOOKING_SUMMARY = '/booking_summary';
  static const CHECKOUT = '/checkout';
  static const FINAL_CHECKOUT = '/final_checkout';


  static get INITIAL => GetStorage().read('isFirstLaunch') == null ||
      GetStorage().read('isFirstLaunch') == true ? INTRO : ROOT;

  static final routes = [
    GetPage(name: INTRO, page: () => IntroView(), binding: IntroBinding()),
    GetPage(name: LOGIN, page: () => LoginView(), binding: AuthBinding(), transition: Transition.zoom),
    GetPage(name: REGISTER, page: () => RegisterView(), binding: AuthBinding(), transition: Transition.zoom),
    GetPage(name: ROOT, page: () => RootView(), binding: RootBinding()),

    GetPage(name: ROOT, page: () => RootView(), binding: RootBinding()),

    GetPage(name: BOOKING_SUMMARY, page: () => BookingSummaryView(), binding: BookingsBinding(), middlewares: [AuthMiddleware()]),
    GetPage(name: CHECKOUT, page: () => CheckoutView(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]),
    GetPage(name: FINAL_CHECKOUT, page: () => FinalCheckoutView(), binding: CheckoutBinding(), middlewares: [AuthMiddleware()]),
    // GetPage(name: NOTIFICATION, page: () => NotificationsView(), binding: NotificationsBinding(), middlewares: [AuthMiddleware()]),
  ];
}
