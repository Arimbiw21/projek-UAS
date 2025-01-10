import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeScreen extends StatefulWidget {
  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  Future<void> addIncome() async {
    await FirebaseFirestore.instance.collection('transactions').add({
      'deskripsi': _descriptionController.text,
      'jumlah': int.parse(_amountController.text),
      'tanggal': DateTime.now(),
      'type': 'income',
    });
    _descriptionController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Income')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Jumlah'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addIncome,
              child: Text('Tambah Income'),
            ),
          ],
        ),
      ),
    );
  }
}
