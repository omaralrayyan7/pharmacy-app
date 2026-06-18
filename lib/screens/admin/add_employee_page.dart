import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Admin screen to add an employee record to the Firestore 'datanew' collection.
/// Fields: First Name (name) + Phone (phone).
class AddEmployeePage extends StatefulWidget {
  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _firstnameController = TextEditingController();
  final _phoneController = TextEditingController();

  // Reference to the Firestore collection
  final CollectionReference _employees =
      FirebaseFirestore.instance.collection('datanew');

  @override
  void dispose() {
    _firstnameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveEmployee() async {
    final String firstname = _firstnameController.text.trim();
    final String phone = _phoneController.text.trim();

    if (firstname.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid details')),
      );
      return;
    }

    try {
      // Add employee data to Firestore
      await _employees.add({
        'name': firstname,  // Saving name
        'phone': phone,     // Saving phone
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Employee details saved successfully!')),
      );

      // Clear the form
      _firstnameController.clear();
      _phoneController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save employee: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Employee')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstnameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'phone'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEmployee, // Call save function when button pressed
              child: const Text('Save Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
