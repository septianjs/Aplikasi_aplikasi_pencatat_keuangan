import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_controller.dart';
import '../home/home_controller.dart';

class AddTransaksiView extends StatelessWidget {
  final AddTransaksiController controller = Get.put(AddTransaksiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Tambah Transaksi"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER ORANGE =================
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Obx(() {
                    final homeC = Get.find<HomeController>();
                    return Text(
                      "Rp ${homeC.saldo.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }),
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

            SizedBox(height: 30),

            // ================= FORM INPUT =================
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Input Nama
                  TextField(
                    onChanged: (v) => controller.nama.value = v,
                    decoration: InputDecoration(
                      labelText: "Nama",
                      hintText: "Masukkan nama transaksi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange, width: 2),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Input Tanggal
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    ),
                    decoration: InputDecoration(
                      labelText: "Tanggal",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange, width: 2),
                      ),
                      suffixIcon: Icon(Icons.calendar_today, color: Colors.orange),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Input Nominal
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      controller.nominal.value = double.tryParse(v) ?? 0;
                    },
                    decoration: InputDecoration(
                      labelText: "Nominal",
                      hintText: "Masukkan nominal",
                      prefixText: "Rp ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange, width: 2),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // ================= PILIH JENIS =================
                  Text(
                    "Jenis Transaksi",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 10),
                  Obx(() => Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: Center(
                            child: Text("Pemasukan"),
                          ),
                          selected: controller.isIncome.value,
                          selectedColor: Colors.orange,
                          backgroundColor: Colors.orange[100],
                          labelStyle: TextStyle(
                            color: controller.isIncome.value 
                                ? Colors.white 
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                          onSelected: (val) {
                            controller.isIncome.value = true;
                          },
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: ChoiceChip(
                          label: Center(
                            child: Text("Pengeluaran"),
                          ),
                          selected: !controller.isIncome.value,
                          selectedColor: Colors.orange,
                          backgroundColor: Colors.orange[100],
                          labelStyle: TextStyle(
                            color: !controller.isIncome.value 
                                ? Colors.white 
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                          onSelected: (val) {
                            controller.isIncome.value = false;
                          },
                        ),
                      ),
                    ],
                  )),

                  SizedBox(height: 40),

                  // ================= BUTTON BATAL & SIMPAN =================
                  Obx(() => Row(
                    children: [
                      // Tombol Batal
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.isSaving.value 
                              ? null 
                              : () {
                                  Get.back();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.orange,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            side: BorderSide(color: Colors.orange, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Batal",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 15),

                      // Tombol Simpan
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.isSaving.value 
                              ? null 
                              : controller.save,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: controller.isSaving.value
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "Simpan",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}