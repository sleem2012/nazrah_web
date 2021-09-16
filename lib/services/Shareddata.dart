import 'package:shared_preferences/shared_preferences.dart';

Future<void> savePhoneNumber(String phoneNo) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('Phone Number', phoneNo);
}

Future<void> saveName(String name) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('Name', name);
}

Future<void> saveLogin(bool login) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('Login', login);
}
