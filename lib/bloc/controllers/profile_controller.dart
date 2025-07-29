import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  //variables
  final RxString name = "".obs;
  final RxString email = "".obs;
  final RxString phone = "".obs;

  //metodos
  Future<void> getProfileUid() async {
    try {
      //1. Pbtener el uid del usuario
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid !=null){
        //2. Obtener el usuario
        final userdb = FirebaseFirestore.instance.collection("users");
        final user = await userdb.doc(uid).get();
        if(user.exists){
          //3. Obtener los datos del usuario
          final data = user.data();
          name.value = data?["name"] ?? "";
          email.value = data?["email"] ?? "";
          phone.value = data?["phone"] ?? "";
        }
      }else{
        debugPrint("No hay usuario autenticado");
      }

    }catch (e) {
      debugPrint(e.toString());
    }
  }
}