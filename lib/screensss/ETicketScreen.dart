import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:teasy/componentsss/TicketActionButtons.dart';
import 'package:teasy/componentsss/TicketHeader.dart';
import 'package:teasy/componentsss/TicketInfoSection.dart';

class ETicketScreen extends StatefulWidget {
  final List<String> selectedSeats;
  final String bookingId,
      passengerName,
      trainNo,
      startStation,
      endStation,
      date,
      departureTime,
      arrivalTime;
  final int ticketPrice;

  const ETicketScreen({
    super.key,
    required this.selectedSeats,
    required this.bookingId,
    required this.passengerName,
    required this.trainNo,
    required this.startStation,
    required this.endStation,
    required this.date,
    required this.departureTime,
    required this.arrivalTime,
    required this.ticketPrice,
  });

  @override
  State<ETicketScreen> createState() => _ETicketScreenState();
}

class _ETicketScreenState extends State<ETicketScreen> {
  final GlobalKey _qrKey = GlobalKey();
  bool _isSaving = false, _isSharing = false;
  String? _savedFilePath;

  // 🔹 Save QR Code Function
  Future<void> _saveQrCode() async {
    setState(() => _isSaving = true);

    try {
      RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/e_ticket_${widget.bookingId}.png";
      final file = File(filePath);
      await file.writeAsBytes(pngBytes);

      setState(() => _savedFilePath = filePath);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("E-Ticket saved at $filePath"),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error saving ticket!"),
          duration: Duration(seconds: 2),
        ),
      );
    }

    setState(() => _isSaving = false);
  }

  // 🔹 Share QR Code Function
  Future<void> _shareQrCode(BuildContext context) async {
    if (_savedFilePath == null) {
      await _saveQrCode();
    }

    if (_savedFilePath != null) {
      setState(() => _isSharing = true);

      try {
        await Share.shareXFiles([
          XFile(_savedFilePath!),
        ], text: "Here is your e-ticket!");
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error sharing ticket!"),
            duration: Duration(seconds: 2),
          ),
        );
      }

      setState(() => _isSharing = false);
    }
  }

  late List ticketData;

  @override
  void initState() {
    List ticket = [
      "trainNo: ${widget.trainNo}",
      "startStation: ${widget.startStation}",
      "endStation: ${widget.endStation}",
      "date: ${widget.date}",
      "departureTime: ${widget.departureTime}",
      "arrivalTime: ${widget.arrivalTime}",
      "passengerName: ${widget.passengerName}",
      "seats: ${widget.selectedSeats.join(", ")}",
      "ticketPrice: ${widget.ticketPrice}",
    ];
    ticketData = ticket;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String seats = widget.selectedSeats.join(", ");
    String qrData =
        "BookingID: ${widget.bookingId}\nName: ${widget.passengerName}\nSeats: $seats\nTrain: ${widget.trainNo}\nJourney: ${widget.startStation} to ${widget.endStation}\nDate: ${widget.date}\nTime: ${widget.departureTime} - ${widget.arrivalTime}";

    return Scaffold(
      appBar: AppBar(
        title: const Text("E-Ticket"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(6),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ), // Black arrow
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const TicketHeader(),
                  TicketInfoSection(
                    trainNo: widget.trainNo,
                    startStation: widget.startStation,
                    endStation: widget.endStation,
                    date: widget.date,
                    departureTime: widget.departureTime,
                    arrivalTime: widget.arrivalTime,
                    passengerName: widget.passengerName,
                    seats: seats,
                    ticketPrice: widget.ticketPrice,
                  ),
                  // 🔹 Increased QR Code Padding
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 65,
                    ), // Increased side padding
                    child: QrImageView(
                      data: jsonEncode(ticketData.toString()),
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),

                  TicketActionButtons(
                    isSaving: _isSaving,
                    isSharing: _isSharing,
                    onSave: _saveQrCode,
                    onShare: () => _shareQrCode(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
