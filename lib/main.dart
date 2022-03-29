// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
          print("========================================");

          print(snapshot.data);
          return GetMaterialApp(
            title: "Application",
            // initialRoute: AppPages.INITIAL,
            // initialRoute: Routes.ADD_PEGAWAI,
            //kiểm tra niếu data có dữ liệu thì vào Home không thì vào Login
            initialRoute: snapshot.data != null? Routes.HOME: Routes.LOGIN_PEGAWAI,
            getPages: AppPages.routes,
          );
        }),
  );
}
