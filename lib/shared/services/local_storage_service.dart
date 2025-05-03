import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._();
  static final LocalStorageService _instance = LocalStorageService._();
  late SharedPreferences _prefs;

  init()async {
    _prefs = await SharedPreferences.getInstance();
  }


  static LocalStorageService setup() {
    return _instance;
  }

  String? getToken() => _prefs.getString('token');
  Future<void> saveToken(String token) => _prefs.setString('token', token);
  Future<void> clearToken() => _prefs.remove('token');

  String? getUser() => _prefs.getString('user');
  Future<void> saveUser(String user) => _prefs.setString('user', user);
  Future<void> clearUser() => _prefs.remove('user');
}