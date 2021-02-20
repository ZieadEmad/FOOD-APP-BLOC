import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences preferences;

Future<void> initpref() async {
  preferences = await SharedPreferences.getInstance();
}

Future<bool> saveToken(String token) => preferences.setString('token', token);

Future<bool> removeToken() => preferences.remove('token');

String getToken() => preferences.getString('token');


Future<bool> saveUserToken(String tokenUser) => preferences.setString('tokenUser', tokenUser);

Future<bool> removeUserToken() => preferences.remove('tokenUser');

String getUserToken() => preferences.getString('tokenUser');

