// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_apps/app/routes/app_pages.dart';

class LoginPegawaiController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      if (emailC.text.isEmail) {
        isLoading.value = true;
        try {
          UserCredential userCredential = await auth.signInWithEmailAndPassword(
              email: emailC.text, password: passC.text);

          //kiểm tra xác thực email
          if (userCredential.user != null) {
            if (userCredential.user!.emailVerified == true) {
              isLoading.value = false;

              if (passC.text == "password") {
                Get.offAllNamed(Routes.NEW_PASSWORD);
              } else {
                Get.offAllNamed(Routes.HOME);
              }
            } else {
              Get.defaultDialog(
                  title: "Not verified",
                  middleText:
                      " You haven't verified this account, please verify your email.",
                  actions: [
                    OutlinedButton(
                        onPressed: () {
                          isLoading.value = false;
                          Get.back();
                        },
                        child: const Text("CANCEL")),
                    //gửi xác thực email
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await userCredential.user!.sendEmailVerification();
                            Get.back();
                            Get.snackbar("Success",
                                "We have successfully sent a verification email to your account.");
                            isLoading.value = false;
                          } catch (e) {
                            isLoading.value = false;
                            Get.snackbar("Error",
                                "Unable to send verification email. Contact admin or customer service.");
                          }
                        },
                        child: const Text("RESENDING "))
                  ]);
            }
          }
          print("----------------------------");
          print(userCredential);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            Get.snackbar("Error", "No user found for that email.");
          } else if (e.code == 'wrong-password') {
            Get.snackbar("Error", "Wrong password provided for that user.");
          }
        }
      } else {
        Get.snackbar("Error", "Email invalid!");
      }
    } else {
      Get.snackbar("Error", "Email and Password can not blank!");
    }
    // print("object");
  }
}
