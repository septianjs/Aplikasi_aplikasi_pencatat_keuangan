import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/transaksi.dart';
import '../home/home_controller.dart';


class AddTransaksiController extends GetxController {
  var nama = "".obs;
  var nominal = 0.0.obs;
  var isIncome = true.obs; // default pemasukan
  var isSaving = false.obs;

  Future<void> save() async {
    // Validasi
    if (nama.value.trim().isEmpty) {
      Get.snackbar(
        "Perhatian",
        "Nama transaksi tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (nominal.value <= 0) {
      Get.snackbar(
        "Perhatian",
        "Nominal harus lebih dari 0",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isSaving.value = true;

      final homeC = Get.find<HomeController>();

      // Buat objek transaksi
      final transaksi = Transaksi(
        nama: nama.value.trim(),
        tanggal: DateTime.now(),
        nominal: nominal.value,
        isIncome: isIncome.value,
      );

      // Simpan ke database melalui HomeController
      await homeC.addTransaksi(transaksi);

      // Kembali ke halaman sebelumnya
      Get.back();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menyimpan transaksi: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSaving.value = false;
    }
  }
}