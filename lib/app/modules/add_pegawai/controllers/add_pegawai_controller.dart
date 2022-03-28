// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void add() async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      if (emailC.text.isEmail) {
        try {
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
                  email: emailC.text, password: "password");
          if (userCredential.user != null) {
            String uid = userCredential.user!.uid;
            //tạo collection trên firestore
            firestore.collection('pegawai').doc(uid).set({
              "nip": nipC.text,
              "name": nameC.text,
              "email": emailC.text,
              "uid": uid,
              "createAt": DateTime.now().toIso8601String()
            });
            //gửi xác thực email
            await userCredential.user!.sendEmailVerification();
            print("----------------------------------");
            print(uid);
          }
          print(userCredential);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("Error", "The password provided is too weak.");
          } else if (e.code == 'email-already-in-use') {
            Get.snackbar("Error", "The account already exists for that email.");
          }
        } catch (e) {
          Get.snackbar("Error", "Unable to add pegawai");
        }
      } else {
        Get.snackbar("Error", " Email Error!");
      }
    } else {
      Get.snackbar("Error", "Nip, Name, Email can not blank!");
    }
  }
}


// try {
//         UserCredential userCredential =
//             await auth.createUserWithEmailAndPassword(
//                 email: emailC.text, password: "SuperSecretPassword!");
//         print(userCredential);
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'weak-password') {
//           Get.snackbar("Error", "The password provided is too weak.");
//         } else if (e.code == 'email-already-in-use') {
//           Get.snackbar("Error", "The account already exists for that email.");
//         }
//       } catch (e) {
//         Get.snackbar("Error", "Unable to add pegawai");
//       }