// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presence_apps/widgets/textfield_widget.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> prosesaddPegawai() async {
    // print("Add Pegawai");
    if (passAdminC.text.isNotEmpty) {
      try {
        //kiem tra passwod

        String emailAdmin = auth.currentUser!.email!;
        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
                email: emailAdmin, password: passAdminC.text);
        print("===============================================");
        print(emailAdmin);
        UserCredential pegawaiCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailC.text, password: passAdminC.text);
        if (pegawaiCredential.user != null) {
          String uid = pegawaiCredential.user!.uid;
          //tạo collection trên firestore
          firestore.collection('pegawai').doc(uid).set({
            "nip": nipC.text,
            "name": nameC.text,
            "email": emailC.text,
            "uid": uid,
            "createAt": DateTime.now().toIso8601String()
          });
          //gửi xác thực email
          await pegawaiCredential.user!.sendEmailVerification();
          //sau đó logout
          await auth.signOut();
          //current user null and loging
          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
                  email: emailAdmin, password: passAdminC.text);
          print("----------------------------------");
          print(uid);
          Get.back();
          Get.back(); //back to home
          Get.snackbar("Succeed ", "Successfully added pegawai");

          print(userCredentialAdmin);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Error", "The password provided is too weak.");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Error", "The account already exists for that email.");
        } else if (e.code == "wrong-password") {
          Get.snackbar("Error", "Admin can't login. Password wrong.");
        } else {
          Get.snackbar("Error", e.code);
        }
      } catch (e) {
        Get.snackbar("Error", "Unable to add pegawai");
      }
    } else {
      Get.snackbar("Error", "Password can not blank!");
    }
  }

  void addPegawai() async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      if (emailC.text.isEmail) {
        Get.defaultDialog(
            title: "Admin Validation ",
            content: Column(
              children: [
                Text("Enter password for admin validation."),
                // TextFieldWidget(controller: controller, title: title)
                // TextField(
                //   controller: passAdminC,
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: "Password",
                //   ),
                // ),
                TextFieldWidget(controller: passAdminC, title: "Password")
              ],
            ),
            actions: [
              OutlinedButton(
                  onPressed: () => Get.back(), child: const Text("CANCEL")),
              ElevatedButton(
                  onPressed: () async {Get.back();
                    await prosesaddPegawai();
                    
                  },
                  child: const Text("ADD PEGAWAI")),
            ]);
      } else {
        Get.snackbar("Error", " Email Error!");
      }
    } else {
      Get.snackbar("Error", "Nip, Name, Email can not blank!");
    }
  }
}
