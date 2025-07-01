import 'package:get/get.dart';
import 'package:flutter/material.dart';
//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//models
import '../../../data/models/user_model.dart';
//google sign in
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthController extends GetxController {
  //variables
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //user
  late String uid;
  final Rx<String> userName = ''.obs;
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  final Rx<String> userProfilePictureUrl = ''.obs;
  final Rx<String> userDni = ''.obs;
  final Rx<String> userPhoneNumber = ''.obs;
  final Rx<String> userType = ''.obs;
  final Rx<DateTime> userCreatedAt = DateTime.now().obs;
  final Rx<AuthStatus> authStatus = AuthStatus.initial.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAuth();
  }

  void _initializeAuth() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        uid = currentUser.uid;
        await _loadUserData();
        authStatus.value = AuthStatus.authenticated;
        debugPrint("Usuario ya autenticado: ${currentUser.email}");
      } else {
        authStatus.value = AuthStatus.unauthenticated;
        debugPrint("No hay usuario autenticado");
      }
    } catch (e) {
      authStatus.value = AuthStatus.unauthenticated;
      debugPrint("Error inicializando autenticación: ${e.toString()}");
    }
  }

  Future<void> _loadUserData() async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data()!;
        userName.value = userData['name'] ?? '';
        userEmail.text = userData['email'] ?? '';
        userProfilePictureUrl.value = userData['profilePictureUrl'] ?? '';
        userDni.value = userData['dni'] ?? '';
        userPhoneNumber.value = userData['phoneNumber'] ?? '';
        userType.value = userData['type'] ?? '';
        userCreatedAt.value = (userData['createdAt'] as Timestamp).toDate();
      }
    } catch (e) {
      debugPrint("Error loading user data: ${e.toString()}");
    }
  }

  //email and password
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      //1. verificar si el usuario esta verificado
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user?.emailVerified == false) {
        Get.snackbar(
          "Error",
          "El usuario no esta verificado",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      } else {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        uid = _firebaseAuth.currentUser!.uid;
        await _loadUserData();
        authStatus.value = AuthStatus.authenticated;
        debugPrint("Login successful");

        Get.offAllNamed('/home');
      }
    } catch (e) {
      authStatus.value = AuthStatus.unauthenticated;
      debugPrint("Error en login: ${e.toString()}");
    }
  }

  //logout
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      authStatus.value = AuthStatus.unauthenticated;

      debugPrint("Logout successful");
      Get.offAllNamed('/welcome');
    } catch (e) {
      debugPrint("Error en logout: ${e.toString()}");
    }
  }

  //create account
  Future<void> createAccount(
    String name,
    String email,
    String password,
    String confirmPassword,
    String dni,
    String type,
  ) async {
    try {
      //validadores
      //1. password
      if (password.length < 6) {
        Get.snackbar("Error", "La contraseña debe tener al menos 6 caracteres");
        return;
      }
      //2. email
      if (!email.contains("@")) {
        Get.snackbar("Error", "El email no es valido");
        return;
      }
      //3. dni
      if (dni.length != 10) {
        Get.snackbar("Error", "El dni debe tener 10 caracteres");
        return;
      }

      //4. repeat password
      if (password != confirmPassword) {
        Get.snackbar("Error", "Las contraseñas no coinciden");
        return;
      }

      //5. create user
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      uid = _firebaseAuth.currentUser!.uid;

      //6. create user in firestore
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "name": name,
        "email": email,
        "profilePictureUrl": "",
        "dni": dni,
        "phoneNumber": "",
        "type": type,
        "settings": [],
        "createdAt": DateTime.now(),
        "isVerified": false,
      });

      //7. verificar correo
      final signedUser = _firebaseAuth.currentUser;
      if (signedUser != null) {
        await signedUser.sendEmailVerification();
        await FirebaseFirestore.instance.collection("users").doc(uid).update({
          "isVerified": false,
        });
      }

      //8. logout
      await logout();

      Get.offAllNamed('/login');
    } catch (e) {
      debugPrint("Error en create account: ${e.toString()}");
    }
  }
}