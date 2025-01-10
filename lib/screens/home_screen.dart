import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catat Pengeluaran'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('transactions').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Belum ada transaksi.'));
          }

          final transactions = snapshot.data!.docs;

          // Menghitung total income dan outcome
          double totalIncome = 0;
          double totalOutcome = 0;
          for (var doc in transactions) {
            final data = doc.data() as Map<String, dynamic>;
            if (data['type'] == 'income') {
              totalIncome += data['jumlah'];
            } else if (data['type'] == 'outcome') {
              totalOutcome += data['jumlah'];
            }
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSummaryCard('Income', totalIncome, Colors.green),
                    _buildSummaryCard('Outcome', totalOutcome, Colors.red),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    final data = transaction.data() as Map<String, dynamic>;

                    return ListTile(
                      leading: Icon(
                        data['type'] == 'income'
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: data['type'] == 'income' ? Colors.green : Colors.red,
                      ),
                      title: Text(data['deskripsi']),
                      subtitle: Text(
                          '${data['type'] == 'income' ? 'Income' : 'Outcome'} - Rp ${data['jumlah']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTransaction(transaction.id),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(String title, double amount, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 18, color: color)),
            SizedBox(height: 8),
            Text('Rp ${amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void _deleteTransaction(String id) {
    FirebaseFirestore.instance.collection('transactions').doc(id).delete().catchError((error) {
      print('Error deleting transaction: $error');
    });
  }
}
