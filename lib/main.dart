import 'package:flutter/material.dart';
import 'package:essenza_app/config/theme/app_theme.dart';
//getx
import 'package:get/get.dart';
//routes
import 'presentation/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Super App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selector: 0).getTheme(),
      getPages: Routes.pages,
      initialRoute: Routes.welcome,
    );
  }
}