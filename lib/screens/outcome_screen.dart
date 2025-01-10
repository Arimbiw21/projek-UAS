import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OutcomeScreen extends StatefulWidget {
  @override
  _OutcomeScreenState createState() => _OutcomeScreenState();
}

class _OutcomeScreenState extends State<OutcomeScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  Future<void> addOutcome() async {
    await FirebaseFirestore.instance.collection('transactions').add({
      'deskripsi': _descriptionController.text,
      'jumlah': int.parse(_amountController.text),
      'tanggal': DateTime.now(),
      'type': 'outcome',
    });
    _descriptionController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Outcome')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('transactions')
                  .where('type', isEqualTo: 'outcome')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['deskripsi']),
                      subtitle: Text('Rp ${data['jumlah']}'),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
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
                ElevatedButton(
                  onPressed: addOutcome,
                  child: Text('Tambah Outcome'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
