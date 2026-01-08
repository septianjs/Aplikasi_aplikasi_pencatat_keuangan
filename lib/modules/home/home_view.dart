import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        }

        return Column(
          children: [
            // ================= HEADER SALDO =================
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 50),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.deepOrange,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Rp ${controller.saldo.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Total Saldo",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // ================= 2 BUTTON (Pilih Tab) =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Tombol PENGELUARAN
                ElevatedButton(
                  onPressed: () {
                    controller.selectedTab.value = 0;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.selectedTab.value == 0
                        ? Colors.orange
                        : Colors.orange[100],
                    foregroundColor: controller.selectedTab.value == 0
                        ? Colors.white
                        : Colors.deepOrange,
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("PENGELUARAN"),
                ),

                // Tombol PEMASUKAN
                ElevatedButton(
                  onPressed: () {
                    controller.selectedTab.value = 1;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.selectedTab.value == 1
                        ? Colors.orange
                        : Colors.orange[100],
                    foregroundColor: controller.selectedTab.value == 1
                        ? Colors.white
                        : Colors.deepOrange,
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("PEMASUKAN"),
                ),
              ],
            ),

            SizedBox(height: 20),

            // ================= LIST & RIWAYAT =================
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    // TEXT RIWAYAT
                    Center(
                      child: Text(
                        "Riwayat",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // LIST TRANSAKSI
                    Expanded(
                      child: () {
                        var list = controller.selectedTab.value == 1
                            ? controller.transaksiList
                                .where((t) => t.isIncome)
                                .toList()
                            : controller.transaksiList
                                .where((t) => !t.isIncome)
                                .toList();

                        if (list.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 80,
                                  color: Colors.grey[300],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "Belum ada transaksi",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (c, i) => Dismissible(
                            key: Key(list[i].id.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              controller.deleteTransaksi(list[i].id!);
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            child: Card(
                              elevation: 2,
                              margin: EdgeInsets.only(bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.orange[100],
                                  child: Icon(
                                    Icons.history,
                                    color: Colors.orange,
                                  ),
                                ),
                                title: Text(
                                  list[i].nama,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "${list[i].tanggal.day}/${list[i].tanggal.month}/${list[i].tanggal.year}",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                trailing: Text(
                                  "Rp ${list[i].nominal.toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: list[i].isIncome 
                                        ? Colors.green 
                                        : Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),

      // ================= TOMBOL TAMBAH =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, size: 28, color: Colors.white),
        onPressed: () {
          Get.toNamed("/add");
        },
      ),
    );
  }
}