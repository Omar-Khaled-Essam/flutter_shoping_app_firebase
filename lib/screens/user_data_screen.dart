import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class UserDataScreen extends StatelessWidget {
  const UserDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final records = FirestoreService().watchRecords();
    return Scaffold(
      appBar: AppBar(title: const Text('Saved records')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: records,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return const Center(
                child: Text(
                    'Could not load records. Check your connection and Firestore rules.'));
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty)
            return const Center(child: Text('No records saved yet.'));
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final data = docs[index].data();
              return Card(
                  color: Colors.white,
                  child: ListTile(
                    leading:
                        const CircleAvatar(child: Icon(Icons.person_outline)),
                    title: Text((data['name'] as String?) ?? 'Unnamed'),
                    subtitle: Text(
                        'Age: ${data['age'] ?? 'N/A'}\nFavourite hobby: ${data['favouriteHobby'] ?? 'N/A'}'),
                    isThreeLine: true,
                  ));
            },
          );
        },
      ),
    );
  }
}
