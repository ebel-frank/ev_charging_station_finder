import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';

class AuthService extends GetxService {
  // Dummy user
  final user = User(
          id: '1',
          name: 'John Doe',
          email: 'test@gmail.com',
          password: '1234567',
          avatar:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREO17hg6KvLlweeZWN0LCEdi-OXM9qGpbQ9w&s")
      .obs;
  late GetStorage _box;

  AuthService() {
    _box = GetStorage();
  }

  Future<AuthService> init() async {
    user.listen((User user) {
      _box.write('current_user', user.toJson());
    });
    await getCurrentUser();
    return this;
  }

  Future getCurrentUser() async {
    if (_box.hasData('current_user')) {
      user.value = User.fromJson(_box.read('current_user'));
      user.value.auth = true;
    } else {
      user.value.auth = false;
    }
  }

  Future signOut() async {
    // Reset user data to dummy data
    user.value =  User(
        id: '1',
        name: 'John Doe',
        email: 'test@gmail.com',
        password: '1234567',
        avatar:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREO17hg6KvLlweeZWN0LCEdi-OXM9qGpbQ9w&s");
    await _box.remove('current_user');
  }

  Future<void> login(User _user) async {
    await Future.delayed(Duration(seconds: 5));
    _user.auth = true;
    user.value = _user;
  }

  Future<void> register(User _user) async {
    await Future.delayed(Duration(seconds: 5));
    _user.auth = true;
    user.value = _user;
  }

  bool get isAuth => user.value.auth ?? false; // TODO: Change to false
}
