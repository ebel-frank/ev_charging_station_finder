import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../../common/helper.dart';
import '../../../common/ui.dart';
import '../../../models/appointment_model.dart';
import '../../../models/station_model.dart';
import '../../../repositories/stations_repository.dart';
import '../../global_widgets/station_bottom_sheet.dart';

class HomeController extends GetxController {
  late StationsRepository _stationsRepository;
  late GoogleMapController mapController;
  final evStations = <String, Marker>{}.obs;
  PointAnnotation? pointAnnotation;
  PointAnnotationManager? pointAnnotationManager;

  final userLocation = const LatLng(6.4440, 3.4390);
  final Location _location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  Rx<LocationData> locationData = LocationData.fromMap({}).obs;

  // ********************

  final duration = "".obs;
  final station = Station().obs;
  final appointment = Appointment().obs;
  final morningTimes = [].obs;
  final afternoonTimes = [].obs;
  final eveningTimes = [].obs;
  final nightTimes = [].obs;
  final loading = true.obs;
  DatePickerController datePickerController = DatePickerController();

  HomeController() {
    _stationsRepository = StationsRepository();
  }

  @override
  void onInit() async {
    super.onInit();
    await requestPermission();
    _location.onLocationChanged.listen((LocationData currentLocation) {
      locationData.value = currentLocation;
    });
    station.listen((Station station) {
      getTimes(
          station.id,
          duration.value.isEmpty
              ? station.availableDurations![0]['id']
              : duration.value);
    });
  }

  void refreshHome({bool isRefresh = false}) async {
    if (isRefresh) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "EV Stations refreshed successfully"));
    }
  }

  Future<void> requestPermission() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData.value = await _location.getLocation();
  }

  void onMapCreated(GoogleMapController controller) async {
    // get location data
    final stations = await _stationsRepository.getNearByStations();
    final Map<String, Marker> markers = {};
    for (final stn in stations) {
      final marker = Marker(
        markerId: MarkerId(stn.name!),
        position: LatLng(stn.lat!, stn.lng!),
        onTap: () {
          station.value = stn;
          duration.value = stn.availableDurations?[0]['id'];
          Get.bottomSheet(
            StationBottomSheet(),
            isScrollControlled: true,
          );
        },
        infoWindow: InfoWindow(
          title: stn.name,
          snippet: stn.address,
        ),
      );
      markers[stn.name!] = marker;
    }
    // Add a custom marker to represent user location
    markers['User'] = Marker(
        markerId: MarkerId("10000"),
        position: userLocation,
        icon: await Helper.getBitmapFromAsset('assets/img/my_marker.png'));
    evStations.clear();
    evStations.addAll(markers);
    mapController = controller;
  }

  Future getTimes(String stationId, String duration, {DateTime? date}) async {
    // Reset the selected appointment
    appointment.update((val) {
      val!.appointmentAt = null;
      val.startAt = null;
      val.endsAt = null;
    });
    ;
    try {
      nightTimes.clear();
      morningTimes.clear();
      afternoonTimes.clear();
      eveningTimes.clear();
      await Future.delayed(
          Duration(seconds: 2)); // Delay - Mimic fetching data from server
      List<dynamic> times = await _stationsRepository.getAvailabilityHours(
          stationId, duration, date ?? DateTime.now());
      for (var timeEntry in times) {
        final dateTime = DateTime.parse(timeEntry.elementAt(0)).toLocal();
        final hour = dateTime.hour;
        if (hour < 6) {
          nightTimes.add(timeEntry);
        } else if (hour < 12) {
          morningTimes.add(timeEntry);
        } else if (hour < 18) {
          afternoonTimes.add(timeEntry);
        } else {
          eveningTimes.add(timeEntry);
        }
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}

class AnnotationClickListener extends OnPointAnnotationClickListener {
  AnnotationClickListener(this.onClick);

  final Function onClick;

  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    onClick(annotation.textField!);
  }
}
