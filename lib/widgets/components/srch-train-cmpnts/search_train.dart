import "package:flutter/material.dart";

class SearchTrain extends StatefulWidget {
  const SearchTrain({super.key});

  @override
  State<SearchTrain> createState() => _SearchTrainState();
}

class _SearchTrainState extends State<SearchTrain> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          // From field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'From',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber.shade700),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.train, color: Colors.amber.shade800),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Select departure station',
                        ),
                        onTap: () {
                          // TODO: Show station selection dialog/screen
                          // Navigator.pushNamed(context, '/stations', arguments: {'type': 'from'});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // To field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'To',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber.shade700),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.train, color: Colors.amber.shade800),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Select arrival station',
                        ),
                        onTap: () {
                          // TODO: Show station selection dialog/screen
                          // Navigator.pushNamed(context, '/stations', arguments: {'type': 'to'});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Departure date field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Departure',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber.shade700),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Text(
                      '+ Add departure date',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.calendar_today, size: 20),
                      onPressed: () async {
                        //TODO: Show date picker
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 90)),
                        );
                        if (picked != null && picked != selectedDate) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
