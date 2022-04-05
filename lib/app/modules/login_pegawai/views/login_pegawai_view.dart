import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_apps/widgets/textfield_widget.dart';

import '../controllers/login_pegawai_controller.dart';

class LoginPegawaiView extends GetView<LoginPegawaiController> {
  const LoginPegawaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPegawaiView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFieldWidget(controller: controller.emailC, title: "Email"),
          const SizedBox(
            height: 20,
          ),
          TextFieldWidget(controller: controller.passC, title: "Password"),
          const SizedBox(
            height: 30,
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.login();
                }
              },
              child:
                  Text(controller.isLoading.isFalse? "LOGIN" : "Loading..."),
            ),
          ),
          TextButton(
              onPressed: () {}, child: const Text("Forgot the password "))
        ],
      ),
    );
  }
}
