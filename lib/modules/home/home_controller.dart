import 'package:get/get.dart';
import '../../models/transaksi.dart';
import '../../helpers/database_helper.dart';


class HomeController extends GetxController {
  var transaksiList = <Transaksi>[].obs;
  var selectedTab = 0.obs; // 0 = Pengeluaran, 1 = Pemasukan
  var isLoading = false.obs;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    loadTransaksi();
  }

  // Load data dari database
  Future<void> loadTransaksi() async {
    try {
      isLoading.value = true;
      final data = await _dbHelper.getAllTransaksi();
      transaksiList.value = data;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal memuat data: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Tambah transaksi ke database
  Future<void> addTransaksi(Transaksi transaksi) async {
    try {
      final id = await _dbHelper.insertTransaksi(transaksi);
      transaksi.id = id;
      transaksiList.insert(0, transaksi); // Insert di awal list
      
      Get.snackbar(
        "Berhasil",
        "Transaksi berhasil ditambahkan",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menambah transaksi: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Update transaksi
  Future<void> updateTransaksi(Transaksi transaksi) async {
    try {
      await _dbHelper.updateTransaksi(transaksi);
      final index = transaksiList.indexWhere((t) => t.id == transaksi.id);
      if (index != -1) {
        transaksiList[index] = transaksi;
      }
      
      Get.snackbar(
        "Berhasil",
        "Transaksi berhasil diupdate",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal mengupdate transaksi: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Hapus transaksi
  Future<void> deleteTransaksi(int id) async {
    try {
      await _dbHelper.deleteTransaksi(id);
      transaksiList.removeWhere((t) => t.id == id);
      
      Get.snackbar(
        "Berhasil",
        "Transaksi berhasil dihapus",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menghapus transaksi: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Hitung saldo
  double get saldo {
    double pemasukan = transaksiList
        .where((t) => t.isIncome)
        .fold(0, (sum, t) => sum + t.nominal);

    double pengeluaran = transaksiList
        .where((t) => !t.isIncome)
        .fold(0, (sum, t) => sum + t.nominal);

    return pemasukan - pengeluaran;
  }

  // Hitung total pemasukan
  double get totalPemasukan {
    return transaksiList
        .where((t) => t.isIncome)
        .fold(0, (sum, t) => sum + t.nominal);
  }

  // Hitung total pengeluaran
  double get totalPengeluaran {
    return transaksiList
        .where((t) => !t.isIncome)
        .fold(0, (sum, t) => sum + t.nominal);
  }
}