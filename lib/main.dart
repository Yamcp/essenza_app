import 'package:flutter/material.dart';
import 'package:essenza_app/config/theme/app_theme.dart';
//getx
import 'package:get/get.dart';
//routes
import 'presentation/routes/routes.dart';
//firebase
import 'package:firebase_core/firebase_core.dart';
//controllers
import 'bloc/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Essenza App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selector: 0).getTheme(),
      getPages: Routes.pages,
      home: const AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Obx(() {
      switch (authController.authStatus.value) {
        case AuthStatus.initial:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        case AuthStatus.authenticated:
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAllNamed(Routes.home);
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        case AuthStatus.unauthenticated:
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.offAllNamed(Routes.welcome);
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
      }
    });
  }
}