import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/assets.dart';
import '../../common/routes.dart';
import '../../services/auth_service.dart';
import '../root/controllers/root_controller.dart';
import 'drawer_link_widget.dart';

class MainDrawerWidget extends StatelessWidget {
  const MainDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Assets.primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Obx(() {
                if (!Get.find<AuthService>().isAuth) {
                  return GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.LOGIN);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome".tr,
                              style: Get.textTheme.headlineSmall),
                          SizedBox(height: 5),
                          Text(
                              "Log into your account or create a new one for free"
                                  .tr,
                              style: Get.textTheme.bodyLarge),
                          SizedBox(height: 15),
                          Wrap(
                            spacing: 10,
                            children: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.LOGIN);
                                },
                                color: Get.theme.colorScheme.secondary,
                                height: 40,
                                elevation: 0,
                                shape: StadiumBorder(
                                    side:
                                        BorderSide(color: Colors.transparent)),
                                child: Wrap(
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 9,
                                  children: [
                                    Icon(Icons.exit_to_app_outlined,
                                        color: Get.theme.primaryColor,
                                        size: 24),
                                    Text(
                                      "Login".tr,
                                      style: Get.textTheme.titleMedium?.merge(
                                          TextStyle(
                                              color: Get.theme.primaryColor)),
                                    ),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                color: Get.theme.focusColor.withOpacity(0.2),
                                height: 40,
                                elevation: 0,
                                onPressed: () {
                                  Get.toNamed(AppRoutes.REGISTER);
                                },
                                shape: StadiumBorder(
                                    side:
                                        BorderSide(color: Colors.transparent)),
                                child: Wrap(
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 9,
                                  children: [
                                    Icon(Icons.person_add_outlined,
                                        color: Get.theme.hintColor, size: 24),
                                    Text(
                                      "Register".tr,
                                      style: Get.textTheme.titleMedium?.merge(
                                          TextStyle(
                                              color: Get.theme.hintColor)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () async {
                      await Get.find<RootController>().changePage(3);
                      Get.back();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: CachedNetworkImage(
                            height: 75,
                            width: 75,
                            fit: BoxFit.cover,
                            imageUrl: Get.find<AuthService>().user.value.avatar,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 100,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error_outline),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          Get.find<AuthService>().user.value.name.trim(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.email,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              Get.find<AuthService>().user.value.email,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }),
              SizedBox(
                height: 16,
              ),
              DrawerLinkWidget(
                icon: Icons.home_rounded,
                text: "Home",
                onTap: (e) async {
                  Get.back();
                  await Get.find<RootController>().changePage(0);
                },
              ),
              DrawerLinkWidget(
                icon: CupertinoIcons.calendar,
                text: "Bookings",
                onTap: (e) async {
                  Get.back();
                  await Get.find<RootController>().changePage(1);
                },
              ),
              Spacer(),
              Obx(() {
                if (Get.find<AuthService>().isAuth) {
                  return DrawerLinkWidget(
                    icon: Icons.logout_rounded,
                    text: "Log out",
                    onTap: (e) async {
                      Get.back();
                      await Get.find<AuthService>().signOut();
                    },
                  );
                } else {
                  return SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
