import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {


  /// Setters

  static setString({String? key, String? value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(key!, value!);
  }

  static setBool({String? key, bool? value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setBool(key!, value!);
  }

  static setInt({String? key, int? value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setInt(key!, value!);
  }

  static setDouble({String? key, double? value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setDouble(key!, value!);
  }

  /// Getters

  static Future<String?> getString({String? key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key!);
  }

  static Future<bool?> getBool({String? key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getBool(key!);
  }

  static Future<int?> getInt({String? key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getInt(key!);
  }

  static Future<double?> getDouble({String? key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getDouble(key!);
  }


}
