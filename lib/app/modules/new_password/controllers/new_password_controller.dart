// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:presence_apps/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "password") {
        try {
          String email = auth.currentUser!.email!;
          await auth.currentUser!.updatePassword(newPassC.text);
          print("------------------------------");
          print(email);
          await auth.signOut();
          await auth.signInWithEmailAndPassword(
              email: email, password: newPassC.text);
          Get.offAllNamed(Routes.HOME);
        }  on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("Error", "password is too weak, at least 6 characters.");
          } 
        } catch (e) {
          Get.snackbar("Error", "Can't create a new password, contact admin/customer service.");
        }
      } else {
        Get.snackbar(
            "Error", "New password is required, do not return the password");
      }
    } else {
      Get.snackbar("Error", "New password is required");
    }
    // print("object");
  }
}
