import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _deskripsi = '';
  double _jumlah = 0;
  String _type = 'income';

  void _saveTransaction() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await FirebaseFirestore.instance.collection('transactions').add({
        'deskripsi': _deskripsi,
        'jumlah': _jumlah,
        'type': _type,
        'tanggal': Timestamp.now(),
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Deskripsi'),
                validator: (value) =>
                value!.isEmpty ? 'Deskripsi tidak boleh kosong' : null,
                onSaved: (value) {
                  _deskripsi = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Jumlah'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Jumlah tidak boleh kosong' : null,
                onSaved: (value) {
                  _jumlah = double.parse(value!);
                },
              ),
              DropdownButtonFormField(
                value: _type,
                decoration: InputDecoration(labelText: 'Tipe Transaksi'),
                items: [
                  DropdownMenuItem(value: 'income', child: Text('Income')),
                  DropdownMenuItem(value: 'outcome', child: Text('Outcome')),
                ],
                onChanged: (value) {
                  setState(() {
                    _type = value as String;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTransaction,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
