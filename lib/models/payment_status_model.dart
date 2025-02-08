import 'parents/model.dart';

class PaymentStatus extends Model {
  String? _status;

  String get status => _status ?? '';

  set status(String? value) {
    _status = value;
  }

  PaymentStatus({String? id, String? status}) {
    _status = status;
    this.id = id;
  }

  PaymentStatus.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _status = stringFromJson(json, 'status');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['status'] = status;
    return data;
  }
}