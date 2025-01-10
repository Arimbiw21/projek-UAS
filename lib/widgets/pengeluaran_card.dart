import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/pengeluaran.dart';

class PengeluaranCard extends StatelessWidget {
  final Pengeluaran pengeluaran;

  PengeluaranCard(this.pengeluaran);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.attach_money),
        ),
        title: Text(pengeluaran.deskripsi),
        subtitle: Text(
          DateFormat('dd MMM yyyy').format(pengeluaran.tanggal),
          style: TextStyle(color: Colors.grey),
        ),
        trailing: Text(
          'Rp ${pengeluaran.jumlah}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
