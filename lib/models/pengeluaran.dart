import 'package:cloud_firestore/cloud_firestore.dart';

class Pengeluaran {
  final String id;
  final String deskripsi;
  final int jumlah;
  final DateTime tanggal;
  final String type;

  Pengeluaran({
    required this.id,
    required this.deskripsi,
    required this.jumlah,
    required this.tanggal,
    required this.type,
  });

  factory Pengeluaran.fromMap(Map<String, dynamic> data, String id) {
    return Pengeluaran(
      id: id,
      deskripsi: data['deskripsi'] ?? '',
      jumlah: data['jumlah'] ?? 0,
      tanggal: (data['tanggal'] as Timestamp).toDate(),
      type: data['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deskripsi': deskripsi,
      'jumlah': jumlah,
      'tanggal': tanggal,
      'type': type,
    };
  }
}
