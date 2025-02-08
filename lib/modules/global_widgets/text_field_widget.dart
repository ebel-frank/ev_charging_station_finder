/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ui.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.validator,
    this.keyboardType,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.iconData,
    this.iconPath,
    this.labelText,
    this.helperText,
    this.obscureText,
    this.suffixIcon,
    this.controller,
    this.isFirst,
    this.isLast,
    this.style,
    this.textAlign,
    this.suffix,
    this.readOnly = false,
    this.disable = false,
  }) : super(key: key);

  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? hintText, helperText;
  final String? errorText;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final IconData? iconData;
  final String? iconPath;
  final bool? obscureText;
  final bool readOnly, disable;
  final bool? isFirst;
  final bool? isLast;
  final Widget? suffixIcon;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 20, bottom: 14, left: 20, right: suffixIcon != null ? 8 : 20),
      margin: EdgeInsets.only(
          left: 20, right: 20, top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: buildBorderRadius,
          boxShadow: [
            BoxShadow(
                color: Get.theme.focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            labelText ?? "",
            style: Get.textTheme.bodyLarge,
            textAlign: textAlign ?? TextAlign.start,
          ),
          TextFormField(
            maxLines: keyboardType == TextInputType.multiline ? null : 1,
            key: key,
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            keyboardType: keyboardType ?? TextInputType.text,
            onSaved: onSaved,
            enabled: !disable,
            onChanged: onChanged,
            validator: validator,
            initialValue: controller == null ? initialValue ?? '' : null,
            style: style ?? Get.textTheme.bodyMedium,
            obscureText: obscureText ?? false,
            textAlign: textAlign ?? TextAlign.start,
            decoration: Ui.getInputDecoration(
              hintText: hintText ?? '',
              helperText: helperText,
              iconPath: iconPath,
              iconData: iconData,
              suffixIcon: suffixIcon,
              suffix: suffix,
              errorText: errorText,
            ),

          ),
        ],
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst ?? false) {
      return BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast ?? false) {
      return BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (isFirst != null && !isFirst! && isLast != null && !isLast!) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst ?? false)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast ?? false)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}

class SimpleTextFieldWidget extends StatelessWidget {
  const SimpleTextFieldWidget({
    Key? key,
    this.onSaved,
    this.onTap,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.initialValue,
    this.controller,
    this.hintText,
    this.errorText,
    this.iconData,
    this.iconPath,
    this.obscureText,
    this.suffixIcon,
    this.readOnly = false,
    this.isFirst,
    this.isLast,
    this.style,
    this.textAlign,
    this.suffix,
  }) : super(key: key);

  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextAlign? textAlign;
  final TextStyle? style;
  final IconData? iconData;
  final String? iconPath;
  final bool? obscureText;
  final bool readOnly;
  final bool? isFirst;
  final bool? isLast;
  final Widget? suffixIcon;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 14, left: 20, right: 8),
      margin: EdgeInsets.only(
          left: 20, right: 20, top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: buildBorderRadius,
          boxShadow: [
            BoxShadow(
                color: Get.theme.focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
      child: TextFormField(
        maxLines: keyboardType == TextInputType.multiline ? null : 1,
        key: key,
        onTap: onTap,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        readOnly: readOnly,
        initialValue: controller == null ? initialValue ?? '' : null,
        style: style ?? Get.textTheme.bodyMedium,
        obscureText: obscureText ?? false,
        textAlign: textAlign ?? TextAlign.start,
        decoration: Ui.getInputDecoration(
          hintText: hintText ?? '',
          iconPath: iconPath,
          iconData: iconData,
          suffixIcon: suffixIcon,
          suffix: suffix,
          errorText: errorText,
        ),
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst ?? false) {
      return BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast ?? false) {
      return BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (isFirst != null && !isFirst! && isLast != null && !isLast!) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst ?? false)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast ?? false)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}
