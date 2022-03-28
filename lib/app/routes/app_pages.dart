import 'package:get/get.dart';

import '../modules/add_pegawai/bindings/add_pegawai_binding.dart';
import '../modules/add_pegawai/views/add_pegawai_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login_pegawai/bindings/login_pegawai_binding.dart';
import '../modules/login_pegawai/views/login_pegawai_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PEGAWAI,
      page: () => const AddPegawaiView(),
      binding: AddPegawaiBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PEGAWAI,
      page: () => const LoginPegawaiView(),
      binding: LoginPegawaiBinding(),
    ),
  ];
}
