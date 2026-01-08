import 'package:get/get.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/add/add_binding.dart';
import '../modules/add/add_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/',
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/add',
      page: () => AddTransaksiView(),
      binding: AddBinding(),
    ),
  ];
}
