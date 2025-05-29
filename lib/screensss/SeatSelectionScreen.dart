import 'package:flutter/material.dart';
import 'package:teasy/componentsss/SeatIndicator.dart';
import 'package:teasy/componentsss/SeatLayout.dart';
import 'package:teasy/screensss/PaymentSummaryScreen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final String bookingId,
      passengerName,
      trainNo,
      startStation,
      endStation,
      date,
      departureTime,
      arrivalTime;
  const SeatSelectionScreen({
    super.key,
    required this.bookingId,
    required this.passengerName,
    required this.trainNo,
    required this.startStation,
    required this.endStation,
    required this.date,
    required this.departureTime,
    required this.arrivalTime,
  });

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<List<String>> seatStatus = List.generate(
    10,
    (_) => List.filled(4, "available"),
  );
  int selectedCount = 0;
  List<String> selectedSeats = [];

  @override
  void initState() {
    super.initState();

    // Example: reserve some seats
    //seatStatus[0][1] = "reserved"; // Seat B1
    //seatStatus[2][3] = "reserved"; // Seat D3
    //seatStatus[4][0] = "reserved"; // Seat A5
  }

  void selectSeat(int row, int col) {
    if (seatStatus[row][col] == "reserved") return;

    setState(() {
      String seat = "${String.fromCharCode(65 + col)}${row + 1}";
      if (seatStatus[row][col] == "available") {
        seatStatus[row][col] = "selected";
        selectedCount++;
        selectedSeats.add(seat);
      } else if (seatStatus[row][col] == "selected") {
        seatStatus[row][col] = "available";
        selectedCount--;
        selectedSeats.remove(seat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
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
        title: Text(
          "Select Your Seats",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Compartment B1",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Pass seatStatus and selectSeat callback
            SeatLayout(seatStatus: seatStatus, selectSeat: selectSeat),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SeatIndicator(color: Colors.yellow.shade400, label: "Reserved"),
                const SizedBox(width: 20),
                SeatIndicator(color: Colors.yellow.shade700, label: "Selected"),
                const SizedBox(width: 20),
                SeatIndicator(color: Colors.white, label: "Available"),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "$selectedCount Seats Selected",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "⚠ Once you have selected the seat and continue, you cannot change it later.",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    side: BorderSide(color: Colors.yellow.shade700),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed:
                      selectedSeats.isNotEmpty
                          ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => PaymentSummaryScreen(
                                      selectedSeats: selectedSeats,
                                      bookingId: widget.bookingId,
                                      passengerName: widget.passengerName,
                                      trainNo: widget.trainNo,
                                      startStation: widget.startStation,
                                      endStation: widget.endStation,
                                      date: widget.date,
                                      departureTime: widget.date,
                                      arrivalTime: widget.arrivalTime,
                                    ),
                              ),
                            );
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedSeats.isNotEmpty
                            ? Colors.yellow.shade700
                            : Colors.grey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
