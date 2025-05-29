import 'package:flutter/material.dart';

class TicketInfoSection extends StatelessWidget {
  final String trainNo, startStation, endStation, date, departureTime, arrivalTime;
  final String passengerName, seats;
  final int ticketPrice;

  const TicketInfoSection({
    super.key,
    required this.trainNo,
    required this.startStation,
    required this.endStation,
    required this.date,
    required this.departureTime,
    required this.arrivalTime,
    required this.passengerName,
    required this.seats,
    required this.ticketPrice,
  });

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text("Train Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const Divider(),
        _infoRow("Train No & Name", trainNo),
        _infoRow("Start Station", startStation),
        _infoRow("End Station", endStation),
        _infoRow("Date", date),
        _infoRow("Departure & Arrival", "$departureTime - $arrivalTime"),
        const SizedBox(height: 10),
        const Text("Passenger Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const Divider(),
        _infoRow("Passenger Name", passengerName),
        _infoRow("Seat No", seats),
        _infoRow("Total Price", "LKR $ticketPrice.00"),
      ],
    );
  }
}
