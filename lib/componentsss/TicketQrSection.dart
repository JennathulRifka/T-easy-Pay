import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


// Your existing QR generation widget
class TicketQrSection extends StatelessWidget {
  final String bookingId, qrData;
  final GlobalKey qrKey;

  const TicketQrSection({
    super.key,
    required this.bookingId,
    required this.qrData,
    required this.qrKey,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RepaintBoundary(
        key: qrKey,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 150.0,
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 8),
              const Text("Booking ID", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(bookingId, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              
              
            ],
          ),
        ),
      ),
    );
  }
}