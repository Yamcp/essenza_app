import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  //varibles
  final RxString name = "".obs;
  final RxString email = "".obs;
  final RxString phone = "".obs;
  final RxString edad = "".obs;
  final RxString sexo = "".obs;
  final RxString estadocivil = "".obs;
  final RxString ocupacion = "".obs;
  final RxString pais = "".obs;
  final RxString ciudad = "".obs;
  final RxString direccion = "".obs;

  //metodos
  Future<void> getProfileUid() async {
    try {
      //1. obtener el uid del usuario
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        //2. obtener el usuario
        final userdb = FirebaseFirestore.instance.collection("users");
        final user = await userdb.doc(uid).get();
        if (user.exists) {
          //3. obtener los datos del usuario
          final data = user.data();
          name.value = data?["name"] ?? "";
          email.value = data?["email"] ?? "";
          phone.value = data?["phone"] ?? "";
          edad.value = data?["edad"] ?? "";
          sexo.value = data?["sexo"] ?? "";
          estadocivil.value = data?["estadocivil"] ?? "";
          ocupacion.value = data?["ocupacion"] ?? "";
          pais.value = data?["pais"] ?? "";
          ciudad.value = data?["ciudad"] ?? "";
          direccion.value = data?["direccion"] ?? "";
          debugPrint("name: ${name.value}");
          debugPrint("email: ${email.value}");
          debugPrint("phone: ${phone.value}");
          debugPrint("edad: ${edad.value}");
          debugPrint("sexo: ${sexo.value}");
          debugPrint("estadocivil: ${estadocivil.value}");
          debugPrint("ocupacion: ${ocupacion.value}");
          debugPrint("pais: ${pais.value}");
          debugPrint("ciudad: ${ciudad.value}");
          debugPrint("direccion: ${direccion.value}");
        }
      } else {
        debugPrint("No hay usuario autenticado");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //actualizar perfil
  Future<void> updateProfile(String name, String phone, String edad, String sexo, String estadocivil, String ocupacion, String pais, String ciudad, String direccion) async {
    try {
      //1. obtener uid
      final uid = FirebaseAuth.instance.currentUser?.uid;

      //2. actualizar
      final userdb = FirebaseFirestore.instance.collection("users");
      await userdb.doc(uid).update({"name": name, "phone": phone, "edad": edad, "sexo": sexo, "estadocivil": estadocivil, "ocupacion": ocupacion, "pais": pais, "ciudad": ciudad, "direccion": direccion});
      debugPrint("Perfil actualizado correctamente");
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}