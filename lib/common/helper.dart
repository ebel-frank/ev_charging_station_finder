import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';

import 'package:ev_charging/common/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

class Helper {
  DateTime? currentBackPressTime;

  static Future<String> copyAssetToStorage(String path) async {
    final tempDir = await getExternalStorageDirectory();
    final file = File('${tempDir?.path}/${path.split('/').last}');

    // Check if the file already exists
    if (await file.exists()) {
      return file.path;
    }

    // If the file doesn't exist, load it from the assets
    final byteData = await rootBundle.load(path);
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file.path;
  }

  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  static String formatDate(DateTime date) {
    // Get the day with ordinal suffix (1st, 2nd, 3rd, etc.)
    String getDayWithSuffix(int day) {
      if (day >= 11 && day <= 13) return '${day}th';
      switch (day % 10) {
        case 1:
          return '${day}st';
        case 2:
          return '${day}nd';
        case 3:
          return '${day}rd';
        default:
          return '${day}th';
      }
    }

    // Map of month numbers to names
    const List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    String dayWithSuffix = getDayWithSuffix(date.day);
    String month = months[date.month - 1];
    String year = date.year.toString();

    // Format: "1st Oct, 2024"
    return '$dayWithSuffix $month, $year';
  }

  static DateTime parseDate(String dateString) {
    String removeOrdinalSuffix(String day) {
      return day.replaceAll(RegExp(r'(st|nd|rd|th)$'), '');
    }

    // Map of month names to their corresponding month numbers
    const Map<String, int> monthMap = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12
    };

    // Split the input string by spaces and comma
    List<String> parts = dateString.split(RegExp(r'[\s,]+'));
    if (parts.length != 3) {
      throw FormatException('Invalid date format: $dateString');
    }

    // Extract and parse day, month, and year
    int day = int.parse(removeOrdinalSuffix(parts[0]));
    int month = monthMap[parts[1]] ??
        (throw FormatException('Invalid month: ${parts[1]}'));
    int year = int.parse(parts[2]);

    // Return the parsed DateTime object
    return DateTime(year, month, day);
  }

  static String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0
        ? 12
        : time.hourOfPeriod; // Handle 12-hour format
    final minute =
        time.minute.toString().padLeft(2, '0'); // Ensure two-digit minutes
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  static TimeOfDay stringToTimeOfDay(String timeString) {
    final parts = timeString.split(' ');
    final time = parts[0].split(':');
    final hour = int.parse(time[0]);
    final minute = int.parse(time[1]);
    final period = parts[1];

    int adjustedHour = hour;
    if (period == 'PM' && adjustedHour != 12) {
      adjustedHour += 12;
    } else if (period == 'AM' && adjustedHour == 12) {
      adjustedHour = 0;
    }

    return TimeOfDay(hour: adjustedHour, minute: minute);
  }

  static String convertDateTime(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime);
      return formattedDate;
    } catch (e) {
      print('Error parsing date: $e');
      return '';
    }
  }

  static Future<dynamic> getFilesInDirectory(String path) async {
    var files = io.Directory(path).listSync();
    print(files);
    // return rootBundle.(path).then(convert.jsonDecode);
  }

  static String toUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  static String toApiUrl(String path) {
    path = toUrl(path);
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.showSnackbar(Ui.defaultSnackBar(message: "Tap again to leave!".tr));
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  static Future<Position> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      throw Exception('Location permissions are permanently denied.');
    }

    // Get the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('User Location: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      throw e;
    }
  }

  static bool isExpired(String timestamp) {
    final cachedTime = DateTime.parse(timestamp);
    return DateTime.now().difference(cachedTime) > const Duration(hours: 24);
  }

  static String encodeEmail(String email) {
    final bytes = utf8.encode(email); // Convert email to bytes
    return base64.encode(bytes); // Encode bytes to Base64 string
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static Future<BitmapDescriptor> getBitmapFromAsset(String path) async {
    final Uint8List markerIcon = await getBytesFromAsset(path, 120);
    return BitmapDescriptor.fromBytes(
      markerIcon,
    );
  }
}
