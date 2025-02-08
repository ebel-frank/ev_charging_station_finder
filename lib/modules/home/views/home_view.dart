import 'package:ev_charging/modules/home/controllers/home_controller.dart';
import 'package:ev_charging/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common/assets.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return GoogleMap(
            onMapCreated: controller.onMapCreated,
            // myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: controller.userLocation,
              zoom: 11.0,
            ),
            markers: controller.evStations.values.toSet(),
          );
        }),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.sort,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
