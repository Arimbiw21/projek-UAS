import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Tambahkan data user ke Firestore
  Future<void> addUser({
    required String userId,
    required String email,
    required String nama,
  }) async {
    await _firestore.collection('users').doc(userId).set({
      'email': email,
      'nama': nama,
    });
  }

  // Tambahkan pengeluaran
  Future<void> addPengeluaran({
    required DateTime tanggal,
    required String deskripsi,
    required int jumlah,
  }) async {
    await _firestore.collection('pengeluaran').add({
      'tanggal': Timestamp.fromDate(tanggal),
      'deskripsi': deskripsi,
      'jumlah': jumlah,
    });
  }

  // Stream pengeluaran
  Stream<QuerySnapshot> getPengeluaranStream() {
    return _firestore.collection('pengeluaran').snapshots();
  }
}
