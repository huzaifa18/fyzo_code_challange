import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: sharedPrefs);
});

class SharedUtility {
  SharedUtility({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  String getName() {
    return sharedPreferences.getString(sharedNameKey) ?? '';
  }

  void setName({required String name}) {
    sharedPreferences.setString(sharedNameKey, name);
  }

  String getDOB() {
    return sharedPreferences.getString(sharedDOBKey) ?? '';
  }

  void setDob({required String dob}) {
    sharedPreferences.setString(sharedDOBKey, dob);
  }
}