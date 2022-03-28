import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presence_apps/widgets/textfield_widget.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewPasswordView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFieldWidget(
              controller: controller.newPassC, title: "New Password"),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                controller.newPassword();
              },
              child: const Text("CONTINUE")),
        ],
      ),
    );
  }
}
