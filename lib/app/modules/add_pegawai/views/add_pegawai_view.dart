import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/textfield_widget.dart';
import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddPegawaiView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
                     TextFieldWidget(controller: controller.nipC, title: 'Nip',),

          const SizedBox(
            height: 20,
          ),
          TextFieldWidget(
            controller: controller.nameC,
            title: 'Name',
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldWidget(
            controller: controller.emailC,
            title: 'Email',
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                controller.add();
              },
              child: const Text("ADD PEGAWAI")),
        ],
      ),
    );
  }
}
