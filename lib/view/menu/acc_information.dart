import 'package:flutter/material.dart';

class AccountInformationPage extends StatefulWidget {
  const AccountInformationPage({super.key});

  @override
  State<AccountInformationPage> createState() => _AccountInformationPageState();
}

class _AccountInformationPageState extends State<AccountInformationPage> {
  String name = "John Doe";
  String gender = "Male";
  String birthday = "1990-01-01";
  String nationality = "Sri Lankan";
  String description = "Frequent traveler";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Information'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.yellow, // Yellow Background
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8), // Adjust padding for size
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildEditableField(
                "Name", name, (value) => setState(() => name = value)),
            const SizedBox(height: 16),
            _buildDropdownField("Gender", gender, ["Male", "Female", "Other"],
                (value) => setState(() => gender = value!)),
            const SizedBox(height: 16),
            _buildDateField("Birthday", birthday, () => _selectDate(context)),
            const SizedBox(height: 16),
            _buildEditableField("Nationality", nationality,
                (value) => setState(() => nationality = value)),
            const SizedBox(height: 16),
            _buildDescriptionField("Description", description,
                (value) => setState(() => description = value)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Save changes
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Information updated successfully')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Save Changes',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(
      String label, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(
          initialValue: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> options,
      Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDateField(String label, String value, Function() onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        InkWell(
          onTap: onTap,
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField(
      String label, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(
          initialValue: value,
          maxLines: 3,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        birthday =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }
}
