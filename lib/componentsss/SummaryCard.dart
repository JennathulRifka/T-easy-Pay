import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String seats;
  final int totalPrice;

  const SummaryCard({super.key, required this.seats, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("One Way Train", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const Divider(),
          _infoRow(Icons.train, "Train No & Name", "1005 Podi Menike"),
          _infoRow(Icons.location_on, "Start Station", "Colombo Fort"),
          _infoRow(Icons.flag, "End Station", "Badulla"),
          _infoRow(Icons.date_range, "Date", "26/09/2024"),
          _infoRow(Icons.access_time, "Departure & Arrival", "05:55 - 16:50"),
          _infoRow(Icons.people, "Passengers", "${seats.split(', ').length}"),
          _infoRow(Icons.airline_seat_recline_normal, "Seats", seats),
          _infoRow(Icons.price_check, "Total Price", "LKR $totalPrice.00"),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo.shade900, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
    );
  }
}
