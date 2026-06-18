import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Admin screen that shows a real-time list of employees from Firestore.
/// Collection: 'datanew'  |  Fields: name (String), phone (String)
///
/// Originally named viewInfo.dart in the source project.
class EmployeeListView extends StatelessWidget {
  // Reference to the Firestore collection
  final CollectionReference _employees =
      FirebaseFirestore.instance.collection('datanew');

  /// Returns a stream that listens for real-time updates in Firestore.
  Stream<QuerySnapshot> getEmployeeData() {
    return _employees.snapshots(); // This listens to real-time updates in Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee List')),
      body: StreamBuilder<QuerySnapshot>(
        stream: getEmployeeData(), // Get stream of data from Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: \${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available.'));
          }

          // Display employee data in a ListView
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var employee = snapshot.data!.docs[index];
              String name = employee['name'] ?? 'No name';
              String phone = employee['phone'];

              return ListTile(
                title: Text(name),
                subtitle: Text(phone),
              );
            },
          );
        },
      ),
    );
  }
}
