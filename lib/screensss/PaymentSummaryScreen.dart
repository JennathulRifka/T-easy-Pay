import 'package:flutter/material.dart';
import 'package:teasy/componentsss/CheckoutButton.dart';
import 'package:teasy/componentsss/ConfirmationCheckbox.dart';
import 'package:teasy/componentsss/PaymentMethodCard.dart';
import 'package:teasy/componentsss/SummaryCard.dart';
import 'package:teasy/componentsss/TermsCheckbox.dart';
import 'package:teasy/screensss/ETicketScreen.dart';


class PaymentSummaryScreen extends StatefulWidget {
  final List<String> selectedSeats;
  final String bookingId,
      passengerName,
      trainNo,
      startStation,
      endStation,
      date,
      departureTime,
      arrivalTime;

  const PaymentSummaryScreen(
      {super.key,
      required this.selectedSeats,
      required this.bookingId,
      required this.passengerName,
      required this.trainNo,
      required this.startStation,
      required this.endStation,
      required this.date,
      required this.departureTime,
      required this.arrivalTime});

  @override
  _PaymentSummaryScreenState createState() => _PaymentSummaryScreenState();
}

class _PaymentSummaryScreenState extends State<PaymentSummaryScreen> {
  bool isConfirmed = false;
  bool isTermsAccepted = false;
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    String seats = widget.selectedSeats.join(", ");
    int totalPrice = widget.selectedSeats.length * 3500;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.yellow.shade700),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Payment Summary",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SummaryCard(seats: seats, totalPrice: totalPrice),
            const SizedBox(height: 10),
            ConfirmationCheckbox(
              value: isConfirmed,
              onChanged: (value) => setState(() => isConfirmed = true),
            ),
            const SizedBox(height: 10),
            PaymentMethodCard(
              selectedPaymentMethod: selectedPaymentMethod,
              onPaymentMethodSelected: (method) =>
                  setState(() => selectedPaymentMethod = method),
            ),
            const SizedBox(height: 10),
            TermsCheckbox(
              value: isTermsAccepted,
              onChanged: (value) => setState(() => isTermsAccepted = true),
            ),
            const SizedBox(height: 20),
            CheckoutButton(
              isEnabled: isConfirmed &&
                  isTermsAccepted &&
                  selectedPaymentMethod != null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ETicketScreen(
                      selectedSeats: widget.selectedSeats,
                      bookingId: widget.bookingId,
                      passengerName: widget.passengerName,
                      trainNo: widget.trainNo,
                      startStation: widget.startStation,
                      endStation: widget.endStation,
                      date: widget.date,
                      departureTime: widget.date,
                      arrivalTime: widget.arrivalTime,
                      ticketPrice: totalPrice,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
