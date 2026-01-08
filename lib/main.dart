import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'modules/home/home_binding.dart';
import 'modules/home/home_view.dart';
import 'modules/add/add_binding.dart';
import 'modules/add/add_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Keuangan Kos',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      getPages: [
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
      ],
    );
  }
}