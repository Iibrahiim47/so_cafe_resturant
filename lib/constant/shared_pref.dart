import 'package:admin_panel_so/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/static_data.dart';

class PreferencesService {
  static const String _token = 'token';
  static const String _isAdmin = 'isAdmin';

  static Future<void> saveUserModal({required LoginResponse model}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_token, model.data ?? '');
    prefs.setBool(_isAdmin, model.isAdmin ?? false);
    StaticData.token = model.data;
  }

  static Future<LoginResponse> getUserModal() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_token) ?? '';
    final isAdmin = prefs.getBool(_isAdmin) ?? false;

    StaticData.token = token;
    return LoginResponse(
      data: token,
      isAdmin: isAdmin,
    );
  }

  static Future<void> clearPreferences() async {
    StaticData.token = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
