import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teasy/components/trn-dtl-pg-cmpnts/btns_bar.dart';
import 'package:teasy/models/train_model.dart';
import 'package:teasy/repositories/train_repository.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final List<String> compartments = ["B1", "B2", "B3"];
  final List<String> classes = ["First class", "Second class", "Third class"];

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedCompartment = "B1";
  String selectedClass = "First class";
  int adultCount = 0;
  int childCount = 0;
  final int adultPrice = 3500;
  final int childPrice = 1800;

  Train? train;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTrain();
  }

  Future<void> fetchTrain() async {
    final repo = TrainRepository();
    try {
      //Replace 'your_train_id' with the actual trainId you want to fetch
      final fetchedTrain = await repo.getTrainById('1015');
      setState(() {
        train = fetchedTrain;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        train = null;
        isLoading = false;
      });
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _incrementAdult() {
    setState(() {
      adultCount++;
    });
  }

  void _decrementAdult() {
    setState(() {
      adultCount--;
    });
  }

  void _incrementChild() {
    setState(() {
      childCount++;
    });
  }

  void _decrementChild() {
    setState(() {
      childCount--;
    });
  }

  void _clearForm() {
    setState(() {
      selectedDate = null;
      selectedTime = null;
      selectedCompartment = compartments[0];
      selectedClass = classes[0];
      adultCount = 0;
      childCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = (adultCount * adultPrice) + (childCount * childPrice);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (train == null) {
      return const Center(child: Text('Train not found'));
    }

    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4.0,
          shadowColor: Colors.black,
          color: const Color.fromRGBO(255, 245, 204, 1.0),
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // date and time row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _selectDate,
                      child: buildItem(
                        icon: Icons.calendar_today,
                        text:
                            selectedDate != null
                                ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                                : "Pick Date",
                      ),
                    ),
                    GestureDetector(
                      onTap: _selectTime,
                      child: buildItem(
                        icon: Icons.access_time_rounded,
                        text:
                            selectedTime != null
                                ? selectedTime!.format(context)
                                : "Pick Time",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // compartment and seat type selection row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildDropdown(
                      "Compartment",
                      Icons.directions_train_sharp,
                      compartments,
                      selectedCompartment,
                      (value) {
                        setState(() {
                          selectedCompartment = value!;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    buildDropdown(
                      "Class Type",
                      Icons.airline_seat_recline_normal_sharp,
                      classes,
                      selectedClass,
                      (value) {
                        setState(() {
                          selectedClass = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // ticket selection
                buildTicketRow(
                  "Adult",
                  adultPrice,
                  adultCount,
                  _incrementAdult,
                  _decrementAdult,
                ),
                const SizedBox(height: 4),
                buildTicketRow(
                  "Child",
                  childPrice,
                  childCount,
                  _incrementChild,
                  _decrementChild,
                ),
                const SizedBox(height: 10),
                // total price
                Text(
                  "Total Price LKR $totalPrice.00",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        BtnsBar(onCancel: _clearForm, train: train!),
      ],
    );
  }
}

Widget buildItem({required IconData icon, required String text}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.brown, width: 2),
    ),
    child: Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

Widget buildDropdown(
  String label,
  IconData icon,
  List<String> items,
  String selectedValue,
  Function(String?) onChanged,
) {
  return Expanded(
    child: Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.brown, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: Colors.black54),
              const SizedBox(width: 5),
              Expanded(
                child: DropdownButton<String>(
                  value: selectedValue,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items:
                      items
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTicketRow(
  String type,
  int price,
  int count,
  Function onIncrement,
  Function onDecrement,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("$type - LKR $price.00", style: const TextStyle(fontSize: 16)),
      Row(
        children: [
          IconButton(
            onPressed: () => onDecrement(),
            icon: const Icon(Icons.remove_circle, color: Colors.red),
          ),
          Text(
            "$count",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () => onIncrement(),
            icon: const Icon(Icons.add_circle, color: Colors.green),
          ),
        ],
      ),
    ],
  );
}
