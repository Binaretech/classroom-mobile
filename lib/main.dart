import 'package:classroom_mobile/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final userData = prefs.getString('userData');

  runApp(App(
    token: token,
    userData: userData,
  ));
}
