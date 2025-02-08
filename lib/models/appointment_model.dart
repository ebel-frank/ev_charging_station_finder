import 'package:ev_charging/models/parents/model.dart';
import 'package:ev_charging/models/payment_model.dart';
import 'package:ev_charging/models/station_model.dart';

class Appointment extends Model {
  Appointment({
    this.station,
    this.appointmentAt,
    this.startAt,
    this.endsAt,
    this.duration,
    this.payment,
  });

  Appointment.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    station = objectFromJson(json, 'station', (e) => Station.fromJson(e));
    station = json['station'] != null ? Station.fromJson(json['station']) : null;
    appointmentAt = dateFromJson(json, 'appointment_at');
    startAt = dateFromJson(json, 'start_at');
    endsAt = dateFromJson(json, 'ends_at');
    duration = stringFromJson(json, 'duration');
    payment = objectFromJson(json, 'payment', (e) => Payment.fromJson(e));
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['station'] = station?.toJson();
    data['appointment_at'] = appointmentAt?.toIso8601String();
    data['start_at'] = startAt?.toIso8601String();
    data['ends_at'] = endsAt?.toIso8601String();
    data['duration'] = duration;
    data['payment'] = payment?.toJson();
    return data;
  }

  Station? station;
  String? duration;
  DateTime? appointmentAt;
  DateTime? startAt;
  DateTime? endsAt;
  Payment? payment;
}
