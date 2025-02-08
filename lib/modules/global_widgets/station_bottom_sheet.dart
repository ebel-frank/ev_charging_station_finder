import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:ev_charging/common/routes.dart';
import 'package:ev_charging/models/station_model.dart';
import 'package:ev_charging/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../common/assets.dart';
import '../../common/ui.dart';
import 'block_button_widget.dart';
import 'chip_widget.dart';

class StationBottomSheet extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        height: Get.height - 90,
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 30,
                offset: Offset(0, -30)),
          ],
        ),
        child: Obx(() {
          return ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: 13, horizontal: (Get.width / 2) - 30),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.secondary.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      //child: SizedBox(height: 1,),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 16,
                )),
                SliverPadding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 12),
                  sliver: SliverToBoxAdapter(
                    child: Text("${controller.station.value.name}",
                        style: Get.textTheme.headlineSmall),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text("${controller.station.value.address}",
                              style: Get.textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.station.value.images!.length,
                          itemBuilder: (context, index) {
                            final imageUrl =
                                controller.station.value.images![index];
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 16,
                                  right: index ==
                                          controller.station.value.images!
                                                  .length -
                                              1
                                      ? 16
                                      : 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  width: 260,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/img/loading.gif',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 60,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error_outline),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                SliverAppBar(
                  toolbarHeight: 0,
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  snap: true,
                  floating: true,
                  bottom: TabBar(
                    tabs: const [
                      Tab(text: 'Details'),
                      Tab(text: 'Availability'),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            ListTile(
                              dense: true,
                              leading: Icon(CupertinoIcons.building_2_fill),
                              title: Text("Tesla"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Divider(),
                            ),
                            ListTile(
                              dense: true,
                              leading: Icon(Icons.public),
                              title: Text("https://www.evstationsfinder.com"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Divider(),
                            ),
                            ListTile(
                              dense: true,
                              leading: Icon(Icons.phone_outlined),
                              title: Text("${controller.station.value.phone}"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Divider(),
                            ),
                            ListTile(
                              dense: true,
                              leading: Icon(Icons.access_time_rounded),
                              title: Text("24 Hours"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Divider(),
                            ),
                            ListTile(
                              dense: true,
                              leading: Icon(Icons.ev_station_outlined),
                              title: Text("Public"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Divider(),
                            ),
                            ListTile(
                              dense: true,
                              leading: Icon(Icons.info_outline_rounded),
                              title: Text(
                                  "This station is currently experiencing higher-than-usual demand. Charging speeds may be temporarily reduced."),
                            ),
                          ],
                        ),
                        Container(
                          decoration: Ui.getBoxDecoration(),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: DatePicker(
                                    DateTime.now(),
                                    width: 60,
                                    height: 90,
                                    daysCount: 30,
                                    controller: controller.datePickerController,
                                    initialSelectedDate: DateTime.now(),
                                    selectionColor: Assets.primaryColor,
                                    selectedTextColor: Get.theme.primaryColor,
                                    locale: Get.locale.toString(),
                                    onDateChange: (date) async {
                                      await controller.getTimes(
                                          controller.station.value.id,
                                          controller.duration.value,
                                          date: date);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 5, left: 20, right: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text("Charging Duration".tr,
                                            style: Get.textTheme.bodyMedium),
                                      ),
                                      Expanded(
                                        child: DropdownButtonFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          isExpanded: true,
                                          value: controller.duration.value,
                                          items: controller
                                              .station.value.availableDurations
                                              ?.map((e) => DropdownMenuItem(
                                                  value: e['id'],
                                                  child: Align(
                                                    // Align the child to the right
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      e['duration'],
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  )))
                                              .toList(),
                                          isDense: true,
                                          onChanged: (value) {
                                            controller.duration.value =
                                                value.toString();
                                            controller.getTimes(
                                                controller.station.value.id!,
                                                controller.duration.value);
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 0, vertical: 0),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 5, left: 20, right: 20),
                                  child: Text("Morning".tr,
                                      style: Get.textTheme.bodyMedium),
                                ),
                                Obx(() {
                                  if (controller.morningTimes.isEmpty) {
                                    return TabBarLoadingWidget();
                                  } else {
                                    return TabBarWidget(
                                      initialSelectedId: "",
                                      tag: 'hours',
                                      tabs: List.generate(
                                          controller.morningTimes.length,
                                          (index) {
                                        final time = controller.morningTimes
                                            .elementAt(index)
                                            .elementAt(0);
                                        bool available = controller.morningTimes
                                            .elementAt(index)
                                            .elementAt(1);
                                        if (available) {
                                          return ChipWidget(
                                            backgroundColor: Get
                                                .theme.colorScheme.secondary
                                                .withOpacity(0.2),
                                            style: Get.textTheme.bodyLarge
                                                ?.merge(TextStyle(
                                                    color: Get.theme.colorScheme
                                                        .secondary)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 15),
                                            tag: 'hours',
                                            text: DateFormat('HH:mm').format(
                                                DateTime.parse(time).toLocal()),
                                            id: time,
                                            onSelected: (id) {
                                              controller.appointment
                                                  .update((val) {
                                                val!.appointmentAt =
                                                    DateTime.now().toLocal();
                                                val.startAt = DateTime.parse(id)
                                                    .toLocal();
                                                val.endsAt = val.startAt!.add(
                                                    Duration(
                                                        minutes: int.parse(
                                                            controller.duration
                                                                .value)));
                                              });
                                            },
                                          );
                                        } else {
                                          return RawChip(
                                            side: BorderSide(
                                                color: Colors.transparent),
                                            elevation: 0,
                                            label: Text(
                                                DateFormat('HH:mm').format(
                                                    DateTime.parse(time)
                                                        .toLocal()),
                                                style: Get.textTheme.bodySmall),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 15),
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.1),
                                            selectedColor:
                                                Get.theme.colorScheme.secondary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            showCheckmark: false,
                                            pressElevation: 0,
                                          ).marginSymmetric(horizontal: 5);
                                        }
                                      }),
                                    );
                                  }
                                }),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 5, left: 20, right: 20),
                                  child: Text("Afternoon".tr,
                                      style: Get.textTheme.bodyMedium),
                                ),
                                Obx(() {
                                  if (controller.afternoonTimes.isEmpty) {
                                    return TabBarLoadingWidget();
                                  } else {
                                    return TabBarWidget(
                                      initialSelectedId: "",
                                      tag: 'hours',
                                      tabs: List.generate(
                                          controller.afternoonTimes.length,
                                          (index) {
                                        final _time = controller.afternoonTimes
                                            .elementAt(index)
                                            .elementAt(0);
                                        bool _available = controller
                                            .afternoonTimes
                                            .elementAt(index)
                                            .elementAt(1);
                                        if (_available) {
                                          return ChipWidget(
                                            backgroundColor: Get
                                                .theme.colorScheme.secondary
                                                .withOpacity(0.2),
                                            style: Get.textTheme.bodyLarge
                                                ?.merge(TextStyle(
                                                    color: Get.theme.colorScheme
                                                        .secondary)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 15),
                                            tag: 'hours',
                                            text: DateFormat('HH:mm').format(
                                                DateTime.parse(_time)
                                                    .toLocal()),
                                            id: _time,
                                            onSelected: (id) {
                                              controller.appointment
                                                  .update((val) {
                                                val!.appointmentAt =
                                                    DateTime.now().toLocal();
                                                val.startAt = DateTime.parse(id)
                                                    .toLocal();
                                                val.endsAt = val.startAt!.add(
                                                    Duration(
                                                        minutes: int.parse(
                                                            controller.duration
                                                                .value)));
                                              });
                                            },
                                          );
                                        } else {
                                          return RawChip(
                                            side: BorderSide(
                                                color: Colors.transparent),
                                            elevation: 0,
                                            label: Text(
                                                DateFormat('HH:mm').format(
                                                    DateTime.parse(_time)
                                                        .toLocal()),
                                                style: Get.textTheme.bodySmall),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 15),
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.1),
                                            selectedColor:
                                                Get.theme.colorScheme.secondary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            showCheckmark: false,
                                            pressElevation: 0,
                                          ).marginSymmetric(horizontal: 5);
                                        }
                                      }),
                                    );
                                  }
                                }),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 5, left: 20, right: 20),
                                  child: Text("Evening".tr,
                                      style: Get.textTheme.bodyMedium),
                                ),
                                Obx(() {
                                  if (controller.eveningTimes.isEmpty) {
                                    return TabBarLoadingWidget();
                                  } else {
                                    return TabBarWidget(
                                      initialSelectedId: "",
                                      tag: 'hours',
                                      tabs: List.generate(
                                          controller.eveningTimes.length,
                                          (index) {
                                        final _time = controller.eveningTimes
                                            .elementAt(index)
                                            .elementAt(0);
                                        bool _available = controller
                                            .eveningTimes
                                            .elementAt(index)
                                            .elementAt(1);
                                        if (_available) {
                                          return ChipWidget(
                                            backgroundColor: Get
                                                .theme.colorScheme.secondary
                                                .withOpacity(0.2),
                                            style: Get.textTheme.bodyLarge
                                                ?.merge(TextStyle(
                                                    color: Get.theme.colorScheme
                                                        .secondary)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 15),
                                            tag: 'hours',
                                            text: DateFormat('HH:mm').format(
                                                DateTime.parse(_time)
                                                    .toLocal()),
                                            id: _time,
                                            onSelected: (id) {
                                              controller.appointment
                                                  .update((val) {
                                                val!.appointmentAt =
                                                    DateTime.now().toLocal();
                                                val.startAt = DateTime.parse(id)
                                                    .toLocal();
                                                val.endsAt = val.startAt!.add(
                                                    Duration(
                                                        minutes: int.parse(
                                                            controller.duration
                                                                .value)));
                                              });
                                            },
                                          );
                                        } else {
                                          return RawChip(
                                            side: BorderSide(
                                                color: Colors.transparent),
                                            elevation: 0,
                                            label: Text(
                                                DateFormat('HH:mm').format(
                                                    DateTime.parse(_time)
                                                        .toLocal()),
                                                style: Get.textTheme.bodySmall),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 15),
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.1),
                                            selectedColor:
                                                Get.theme.colorScheme.secondary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            showCheckmark: true,
                                            pressElevation: 0,
                                          ).marginSymmetric(horizontal: 5);
                                        }
                                      }),
                                    );
                                  }
                                }),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 5, left: 20, right: 20),
                                  child: Text("Night".tr,
                                      style: Get.textTheme.bodyMedium),
                                ),
                                Obx(() {
                                  if (controller.nightTimes.isEmpty) {
                                    return TabBarLoadingWidget();
                                  } else {
                                    return TabBarWidget(
                                      initialSelectedId: "",
                                      tag: 'hours',
                                      tabs: List.generate(
                                          controller.nightTimes.length,
                                          (index) {
                                        final _time = controller.nightTimes
                                            .elementAt(index)
                                            .elementAt(0);
                                        bool _available = controller.nightTimes
                                            .elementAt(index)
                                            .elementAt(1);
                                        if (_available) {
                                          return ChipWidget(
                                            backgroundColor: Get
                                                .theme.colorScheme.secondary
                                                .withOpacity(0.2),
                                            style: Get.textTheme.bodyLarge
                                                ?.merge(TextStyle(
                                                    color: Get.theme.colorScheme
                                                        .secondary)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 15),
                                            tag: 'hours',
                                            text: DateFormat('HH:mm').format(
                                                DateTime.parse(_time)
                                                    .toLocal()),
                                            id: _time,
                                            onSelected: (id) {
                                              controller.appointment
                                                  .update((val) {
                                                val!.appointmentAt =
                                                    DateTime.now().toLocal();
                                                val.startAt = DateTime.parse(id)
                                                    .toLocal();
                                                val.endsAt = val.startAt!.add(
                                                    Duration(
                                                        minutes: int.parse(
                                                            controller.duration
                                                                .value)));
                                              });
                                            },
                                          );
                                        } else {
                                          return RawChip(
                                            side: BorderSide(
                                                color: Colors.transparent),
                                            elevation: 0,
                                            label: Text(
                                                DateFormat('HH:mm').format(
                                                    DateTime.parse(_time)
                                                        .toLocal()),
                                                style: Get.textTheme.bodySmall),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 15),
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.1),
                                            selectedColor:
                                                Get.theme.colorScheme.secondary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            showCheckmark: false,
                                            pressElevation: 0,
                                          ).marginSymmetric(horizontal: 5);
                                        }
                                      }),
                                    );
                                  }
                                }),
                                SizedBox(
                                  height: 10,
                                ),
                                Obx(() {
                                  return BlockButtonWidget(
                                          width: double.infinity,
                                          text: Stack(
                                            alignment:
                                                AlignmentDirectional.centerEnd,
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  "Book time slot".tr,
                                                  textAlign: TextAlign.center,
                                                  style: Get
                                                      .textTheme.titleLarge
                                                      ?.merge(
                                                    TextStyle(
                                                        color: Get.theme
                                                            .primaryColor),
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 20,
                                                color: Get.theme.primaryColor,
                                              )
                                            ],
                                          ),
                                          color: Assets.primaryColor,
                                          onPressed: controller.appointment
                                                      .value.appointmentAt ==
                                                  null
                                              ? null
                                              : () async {
                                                  controller.appointment.value
                                                          .station =
                                                      controller.station.value;
                                                  controller.appointment.value
                                                          .duration =
                                                      controller.duration.value;
                                                  Get.toNamed(
                                                      AppRoutes.BOOKING_SUMMARY,
                                                      arguments: controller
                                                          .appointment.value);
                                                })
                                      .paddingSymmetric(
                                          horizontal: 20, vertical: 20);
                                })
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
                // SizedBox(height: 16,)
              ],
            ),
          );
        }),
      ),
    );
  }
}
