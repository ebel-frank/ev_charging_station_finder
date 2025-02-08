import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../services/settings_service.dart';
import 'parents/model.dart';

class User extends Model{
  String? _name;
  String? _email;
  String? _password;
  String? _avatar;
  bool? _auth;

  User(
      {String? id,
      String? name,
      String? email,
      String? password,
      String? avatar,
      bool? auth}) {
    this.id = id;
    _auth = auth;
    _avatar = avatar;
    _email = email;
    _password = password;
    _name = name;
  }

  User.fromJson(Map<String, dynamic>? json) {
    _name = stringFromJson(json, 'name');
    _email = stringFromJson(json, 'email');
    _avatar = stringFromJson(json, 'avatar');
    _auth = boolFromJson(json, 'auth');
    super.fromJson(json);
  }

  bool? get auth => _auth;

  set auth(bool? value) {
    _auth = value;
  }

  String get avatar => _avatar ?? "";

  set avatar(String? value) {
    _avatar = value;
  }

  String get email => _email ?? '';

  set email(String? value) {
    _email = value;
  }

  String get password => _password ?? '';

  set password(String? value) {
    _password = value;
  }

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      email.hashCode ^
      avatar.hashCode ^
      auth.hashCode;

  String get name => _name ?? '';

  set name(String? value) {
    _name = value;
  }

  @override
  bool operator ==(dynamic other) =>
      super == other &&
      other is User &&
      runtimeType == other.runtimeType &&
      name == other.name &&
      email == other.email &&
      avatar == other.avatar &&
      auth == other.auth;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['auth'] = auth;
    data['avatar'] = avatar;
    return data;
  }

}
