import 'package:get/get.dart';

import 'parents/model.dart';

class PaymentMethod extends Model {
  String? _name;
  String? _description;
  String? _logo;
  int? _order;
  bool? _isDefault;

  PaymentMethod(
      {String? id,
      String? name,
      String? description,
      bool? isDefault = false,
      String? logo}) {
    this.id = id;
    _isDefault = isDefault;
    _description = description;
    _name = name;
    _logo = logo;
  }

  PaymentMethod.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _name = stringFromJson(json, 'name');
    _description = stringFromJson(json, 'description');
    _logo = stringFromJson(json, 'logo');
    _order = intFromJson(json, 'order');
  }

  String get description => _description ?? '';

  set description(String? value) {
    _description = value;
  }

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      order.hashCode;

  bool get isDefault => _isDefault ?? false;

  set isDefault(bool? value) {
    _isDefault = value;
  }

  String get name {
    _name = _name ?? "Not Paid".tr;
    return _name!;
  }

  set name(String? value) {
    _name = value;
  }

  int get order => _order ?? 0;

  set order(int? value) {
    _order = value;
  }

  String get logo => _logo ?? '';

  set logo(String? value) {
    _logo = value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is PaymentMethod &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          order == other.order;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
