import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Train {
  final String trainNo;
  final String type;
  final String departure;
  final String arrival;
  final String duration;
  final String trainType;
  final String status;
  final int available;
  final List<String> classes;

  Train({
    required this.trainNo,
    required this.type,
    required this.departure,
    required this.arrival,
    required this.duration,
    required this.trainType,
    required this.status,
    required this.available,
    required this.classes,
  });

  factory Train.fromJson(Map<String, dynamic> json) {
    return Train(
      trainNo: json['trainNo'] as String,
      type: json['type'] as String,
      departure: json['departure'] as String,
      arrival: json['arrival'] as String,
      duration: json['duration'] as String,
      trainType: json['trainType'] as String,
      status: json['status'] as String,
      available: json['available'] as int,
      classes: (json['classes'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'trainNo': trainNo,
        'type': type,
        'departure': departure,
        'arrival': arrival,
        'duration': duration,
        'trainType': trainType,
        'status': status,
        'available': available,
        'classes': classes,
      };
}

class TrainSearchScreen extends StatefulWidget {
  const TrainSearchScreen({Key? key}) : super(key: key);

  @override
  State<TrainSearchScreen> createState() => _TrainSearchScreenState();
}

class _TrainSearchScreenState extends State<TrainSearchScreen>
    with SingleTickerProviderStateMixin {
  DateTime? selectedDate;
  String fromStation = '';
  String toStation = '';
  bool isLoading = false;
  bool hasSearched = false;
  String? selectedTrainTypeFilter;
  String? selectedTimeFilter;
  late TabController _tabController;
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final List<Train> savedTrains = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        setState(() {
          hasSearched = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  final List<Train> trainList = [
    Train(
      trainNo: '1019',
      type: 'Intercity',
      departure: '07:00',
      arrival: '09:38',
      duration: '2 hrs 38 mins',
      trainType: 'Express',
      status: 'On Time',
      available: 45,
      classes: ['1st Class', '2nd Class'],
    ),
    Train(
      trainNo: '1015',
      type: 'Udarata Menike',
      departure: '08:30',
      arrival: '11:03',
      duration: '2 hrs 33 mins',
      trainType: 'Local',
      status: 'Delayed',
      available: 12,
      classes: ['2nd Class', '3rd Class'],
    ),
    Train(
      trainNo: '1022',
      type: 'Rajarata Express',
      departure: '10:15',
      arrival: '12:45',
      duration: '2 hrs 30 mins',
      trainType: 'Express',
      status: 'On Time',
      available: 32,
      classes: ['1st Class', '2nd Class', '3rd Class'],
    ),
    Train(
      trainNo: '1030',
      type: 'Podi Menike',
      departure: '13:00',
      arrival: '15:40',
      duration: '2 hrs 40 mins',
      trainType: 'Express',
      status: 'Cancelled',
      available: 0,
      classes: [],
    ),
  ];

  final List<String> stations = [
    'Colombo Fort',
    'Kandy',
    'Galle',
    'Matara',
    'Beliatta',
    'Anuradhapura',
    'Badulla',
    'Nanu Oya',
    'Hatton',
    'Ella',
    'Jaffna',
    'Trincomalee',
    'Batticaloa'
  ];

  Map<String, dynamic> getStatusStyle(String status) {
    switch (status) {
      case 'On Time':
        return {
          'background': Colors.green.shade100,
          'textColor': Colors.green.shade800,
          'label': 'On Time',
        };
      case 'Delayed':
        return {
          'background': Colors.amber.shade100,
          'textColor': Colors.amber.shade800,
          'label': 'Delayed',
        };
      case 'Cancelled':
        return {
          'background': Colors.red.shade100,
          'textColor': Colors.red.shade800,
          'label': 'Cancelled',
        };
      default:
        return {
          'background': Colors.grey.shade100,
          'textColor': Colors.grey.shade800,
          'label': 'Unknown',
        };
    }
  }

  void _toggleSaveTrain(Train train) {
    setState(() {
      if (savedTrains.any((t) => t.trainNo == train.trainNo)) {
        savedTrains.removeWhere((t) => t.trainNo == train.trainNo);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${train.type} removed from saved')),
        );
      } else {
        savedTrains.add(train);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${train.type} saved')),
        );
      }
    });
  }

  void _searchTrains() {
    if (fromStation.isEmpty || toStation.isEmpty || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (fromStation == toStation) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Departure and arrival stations cannot be the same'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
        hasSearched = true;
      });
    });
  }

  void _exportToFile() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Export Options',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildExportOption(
                    icon: Icons.picture_as_pdf,
                    label: 'PDF',
                    color: Colors.red,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('PDF export not implemented')),
                      );
                    },
                  ),
                  _buildExportOption(
                    icon: Icons.print,
                    label: 'Print',
                    color: Colors.amber,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Printing not implemented')),
                      );
                    },
                  ),
                  _buildExportOption(
                    icon: Icons.share,
                    label: 'Share',
                    color: Colors.green,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sharing not implemented')),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExportOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSearchTab(),
                  _buildSavedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.amber,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.amber,
          tabs: const [
            Tab(icon: Icon(Icons.search), text: 'Search'),
            Tab(icon: Icon(Icons.bookmark), text: 'Saved'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.amber.shade100,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Back button not implemented')),
                );
              },
            ),
          ),
          const Text(
            'Train Finder',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none, color: Colors.amber.shade700),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notifications not implemented')),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.person_outline, color: Colors.amber.shade700),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile not implemented')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSearchForm(),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (hasSearched)
            _buildTrainList(),
        ],
      ),
    );
  }

  Widget _buildSavedTab() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saved Trains',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            savedTrains.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_border,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No saved trains yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Save trains from the search tab to view them here',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: savedTrains.map((train) => _buildTrainCard(train)).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchForm() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'From',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              _buildStationAutocomplete(
                controller: _fromController,
                hintText: 'Enter departure station',
                isFromStation: true,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(child: Divider()),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.amber.shade300,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.swap_vert, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      final temp = fromStation;
                      fromStation = toStation;
                      toStation = temp;
                      _fromController.text = fromStation;
                      _toController.text = toStation;
                    });
                  },
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),
      
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'To',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              _buildStationAutocomplete(
                controller: _toController,
                hintText: 'Enter arrival station',
                isFromStation: false,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Departure Date',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.amber.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 90)),
                          );
                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            selectedDate != null
                                ? DateFormat('EEE, MMM d, yyyy').format(selectedDate!)
                                : 'Select date',
                            style: TextStyle(
                              color: selectedDate != null ? Colors.black : Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (selectedDate != null)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            selectedDate = null;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _searchTrains,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Colors.amber.shade300,
            ),
            child: const Text(
              'Search Trains',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationAutocomplete({
    required TextEditingController controller,
    required String hintText,
    required bool isFromStation,
  }) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return stations;
        }
        return stations.where((station) =>
            station.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (String selection) {
        setState(() {
          if (isFromStation) {
            fromStation = selection;
            _fromController.text = selection;
          } else {
            toStation = selection;
            _toController.text = selection;
          }
        });
      },
      fieldViewBuilder: (context, fieldController, focusNode, onFieldSubmitted) {
        if (controller.text != fieldController.text) {
          fieldController.text = controller.text;
        }
        return TextFormField(
          controller: fieldController,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            prefixIcon: Icon(Icons.train, color: Colors.amber.shade700),
            suffixIcon: fieldController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      fieldController.clear();
                      controller.clear();
                      setState(() {
                        if (isFromStation) {
                          fromStation = '';
                        } else {
                          toStation = '';
                        }
                      });
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            controller.text = value;
            setState(() {
              if (isFromStation) {
                fromStation = value;
              } else {
                toStation = value;
              }
            });
          },
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    title: Text(option),
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrainList() {
    List<Train> filteredTrains = trainList;
    if (selectedTrainTypeFilter != null && selectedTrainTypeFilter != 'All') {
      filteredTrains = filteredTrains
          .where((train) => train.trainType == selectedTrainTypeFilter)
          .toList();
    }
    if (selectedTimeFilter != null) {
      filteredTrains = filteredTrains.where((train) {
        final hour = int.parse(train.departure.split(':')[0]);
        if (selectedTimeFilter == 'Morning') return hour < 12;
        if (selectedTimeFilter == 'Afternoon') return hour >= 12 && hour < 17;
        if (selectedTimeFilter == 'Evening') return hour >= 17;
        return true;
      }).toList();
    }

    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Found ${filteredTrains.length} trains',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: _exportToFile,
                    child: Row(
                      children: [
                        Icon(Icons.file_download_outlined,
                            size: 18, color: Colors.black87),
                        const SizedBox(width: 4),
                        Text(
                          'Export',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return _buildFilterBottomSheet();
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.filter_list,
                            size: 18, color: Colors.black),
                        const SizedBox(width: 4),
                        Text(
                          'Filter',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (selectedDate != null)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today,
                      size: 16, color: Colors.amber.shade700),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('EEEE, MMMM d, yyyy').format(selectedDate!),
                    style: TextStyle(color: Colors.amber.shade900),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          filteredTrains.isEmpty
              ? const Center(child: Text('No trains match the selected filters'))
              : Column(
                  children: filteredTrains
                      .map((train) => _buildTrainCard(train))
                      .toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildFilterBottomSheet() {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          height: 320,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Trains',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Train Type',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: ['All', 'Express', 'Local']
                    .map((label) => _buildFilterChip(label, selectedTrainTypeFilter,
                        (value) {
                  setModalState(() {
                    selectedTrainTypeFilter = value;
                  });
                  setState(() {
                    selectedTrainTypeFilter = value;
                  });
                }))
                    .toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Departure Time',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: ['Morning', 'Afternoon', 'Evening']
                    .map((label) => _buildFilterChip(label, selectedTimeFilter, (value) {
                          setModalState(() {
                            selectedTimeFilter = value;
                          });
                          setState(() {
                            selectedTimeFilter = value;
                          });
                        }))
                    .toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Apply Filters'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label, String? selectedFilter, Function(String?) onSelected) {
    final isSelected = selectedFilter == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: Colors.amber.shade700,
      labelStyle: TextStyle(
        color: isSelected ? Colors.black87 : Colors.black,
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
      ),
      onSelected: (selected) {
        onSelected(selected ? label : null);
      },
    );
  }

  Widget _buildTrainCard(Train train) {

    final bool isLowAvailability = train.available < 15;
    final statusStyle = getStatusStyle(train.status);
    final bool isSaved = savedTrains.any((t) => t.trainNo == train.trainNo);

    // Parse and format departure and arrival times to AM/PM
    String formattedDeparture = train.departure;
    String formattedArrival = train.arrival;
    try {
      final departureTime = DateFormat.Hm().parse(train.departure);
      final arrivalTime = DateFormat.Hm().parse(train.arrival);
      formattedDeparture = DateFormat.jm().format(departureTime); // e.g., 7:00 AM
      formattedArrival = DateFormat.jm().format(arrivalTime); // e.g., 9:38 AM
    } catch (e) {
      // Fallback to original time if parsing fails
      formattedDeparture = train.departure;
      formattedArrival = train.arrival;
    }

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(train.type),
            content: Text(
              'Train No: ${train.trainNo}\n'
              'Departure: $formattedDeparture\n'
              'Arrival: $formattedArrival\n'
              'Duration: ${train.duration}\n'
              'Status: ${statusStyle['label']}\n'
              'Classes: ${train.classes.isEmpty ? 'None' : train.classes.join(', ')}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade50, Colors.amber.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          train.trainNo,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber.shade800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            train.type,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            train.trainType,
                            style: TextStyle(
                              color: Colors.amber.shade700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Semantics(
                        label: 'Train status: ${statusStyle['label']}',
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: statusStyle['background'] as Color,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            statusStyle['label'] as String,
                            style: TextStyle(
                              color: statusStyle['textColor'] as Color,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Semantics(
                        label: isSaved ? 'Remove from saved' : 'Save train',
                        child: IconButton(
                          icon: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: Colors.amber.shade700,
                            size: 20,
                          ),
                          onPressed: () => _toggleSaveTrain(train),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Semantics(
                    label: 'Departure time: $formattedDeparture',
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.amber.shade600,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formattedDeparture,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Departure',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Semantics(
                    label: 'Travel duration: ${train.duration}',
                    child: Column(
                      children: [
                        Text(
                          train.duration,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.amber.shade600,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  Semantics(
                    label: 'Arrival time: $formattedArrival',
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              formattedArrival,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Arrival',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.location_on,
                          color: Colors.amber.shade600,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Semantics(
                    label: 'Availability: ${train.available} seats',
                    child: Row(
                      children: [
                        Icon(
                          isLowAvailability ? Icons.warning_amber : Icons.event_seat,
                          color:
                              isLowAvailability ? Colors.red.shade600 : Colors.green.shade600,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isLowAvailability
                              ? 'Low Availability'
                              : '${train.available} Seats',
                          style: TextStyle(
                            color: isLowAvailability
                                ? Colors.red.shade600
                                : Colors.green.shade600,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Semantics(
                    label:
                        'Available classes: ${train.classes.isEmpty ? 'None' : train.classes.join(', ')}',
                    child: Wrap(
                      spacing: 6,
                      children: train.classes.isEmpty
                          ? [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'No Classes',
                                  style: TextStyle(fontSize: 10, color: Colors.grey),
                                ),
                              ),
                            ]
                          : train.classes.map((classType) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  classType,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.amber.shade900,
                                  ),
                                ),
                              );
                            }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



}