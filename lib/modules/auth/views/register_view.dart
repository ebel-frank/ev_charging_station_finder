import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../common/routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/phone_field_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../root/controllers/root_controller.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    controller.registerFormKey = new GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Register".tr,
            style: Get.textTheme.titleLarge,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: () => {Get.back()},
          ),
        ),
        body: Form(
          key: controller.registerFormKey,
          child: ListView(
            primary: true,
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  Get.find<SettingsService>().appName,
                  style: Get.textTheme.titleLarge
                      ?.merge(TextStyle(fontSize: 24)),
                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  "Welcome to the best EV station finder system!".tr,
                  style: Get.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFieldWidget(
                    labelText: "Full Name".tr,
                    hintText: "John Doe".tr,
                    initialValue: controller.currentUser.value.name,
                    onSaved: (input) =>
                    controller.currentUser.value.name = input,
                    validator: (input) => input!.length < 3
                        ? "Should be more than 3 characters".tr
                        : null,
                    iconData: Icons.person_outline,
                    isFirst: true,
                    isLast: false,
                  ),
                  TextFieldWidget(
                    labelText: "Email Address".tr,
                    hintText: "johndoe@gmail.com".tr,
                    initialValue: controller.currentUser.value.email,
                    onSaved: (input) =>
                    controller.currentUser.value.email = input,
                    validator: (input) => !input!.contains('@')
                        ? "Should be a valid email".tr
                        : null,
                    iconData: Icons.alternate_email,
                    isFirst: false,
                    isLast: false,
                  ),
                  Obx(() {
                    return TextFieldWidget(
                      labelText: "Password".tr,
                      hintText: "••••••••••••".tr,
                      initialValue: controller.currentUser.value.password,
                      onSaved: (input) =>
                      controller.currentUser.value.password = input,
                      validator: (input) => input!.length < 3
                          ? "Should be more than 3 characters".tr
                          : null,
                      obscureText: controller.hidePassword.value,
                      iconData: Icons.lock_outline,
                      keyboardType: TextInputType.visiblePassword,
                      isLast: true,
                      isFirst: false,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.hidePassword.value =
                          !controller.hidePassword.value;
                        },
                        color: Theme.of(context).focusColor,
                        icon: Icon(controller.hidePassword.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                      ),
                    );
                  }),

                  SizedBox(height: 30),
                  BlockButtonWidget(
                    onPressed: () {
                      controller.register();
                    },
                    color: Get.theme.colorScheme.secondary,
                    text: Obx(() {
                      if (controller.loading.value) {
                        return SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      return Text(
                        "Register".tr,
                        style: Get.textTheme.titleMedium
                            ?.merge(TextStyle(color: Get.theme.primaryColor)),
                      );
                    }
                    ),
                  ).paddingSymmetric(vertical: 10, horizontal: 20),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: RichText(text: TextSpan(
                      text: "Already have an account? ".tr,
                      style: Get.textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: "Login".tr,
                          style: Get.textTheme.bodyMedium
                              ?.merge(TextStyle(color: Get.theme.colorScheme.primary)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offNamed(AppRoutes.LOGIN);
                            },
                        ),
                      ],
                    )).paddingSymmetric(vertical: 20),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
