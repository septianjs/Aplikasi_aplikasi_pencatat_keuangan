class Transaksi {
  int? id;
  String nama;
  DateTime tanggal;
  double nominal;
  bool isIncome;

  Transaksi({
    this.id,
    required this.nama,
    required this.tanggal,
    required this.nominal,
    required this.isIncome,
  });

  // Convert Transaksi to Map (untuk database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'tanggal': tanggal.toIso8601String(),
      'nominal': nominal,
      'isIncome': isIncome ? 1 : 0,
    };
  }

  // Convert Map to Transaksi (dari database)
  factory Transaksi.fromMap(Map<String, dynamic> map) {
    return Transaksi(
      id: map['id'],
      nama: map['nama'],
      tanggal: DateTime.parse(map['tanggal']),
      nominal: map['nominal'],
      isIncome: map['isIncome'] == 1,
    );
  }
}