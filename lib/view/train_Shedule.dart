import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:teasy/models/train_shedule_model.dart';
import 'dart:async';
import 'package:teasy/repositories/trainshedule_service.dart';


// Define color constants for reusability
const kPrimaryColor = Colors.amber;
const kPrimaryLight = Color(0xFFFFF8E1);
const kTextColor = Colors.black87;

class TrainSearchScreen extends StatefulWidget {
  const TrainSearchScreen({super.key});

  @override
  State<TrainSearchScreen> createState() => _TrainSearchScreenState();
}

class _TrainSearchScreenState extends State<TrainSearchScreen>
    with SingleTickerProviderStateMixin {
  final Trainlistservice _trainService = Trainlistservice();
  DateTime? selectedDate;
  String fromStation = '';
  String toStation = '';
  String? selectedTrainTypeFilter;
  String? selectedTimeFilter;
  late TabController _tabController;
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  List<Train> trainList = [];
  List<Train> savedTrains = [];
  bool isSearched = false;
  bool isLoading = false;

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    _loadInitialTrains();
  }

  void _handleTabChange() {
    if (_tabController.index == 0) {
      setState(() {
        isSearched = false;
      });
    }
  }

  Future<void> _loadInitialTrains() async {
    setState(() => isLoading = true);
    try {
      final trains = await _trainService.getTrains().first.timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException('Failed to load trains'),
          );
      setState(() {
        trainList = trains;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      _showErrorSnackBar('Error loading trains: $e');
    }
  }

  Future<void> _searchTrainsFromFirestore() async {
    if (fromStation.isEmpty || toStation.isEmpty || selectedDate == null) {
      _showErrorSnackBar('Please fill all required fields');
      return;
    }
    if (fromStation == toStation) {
      _showErrorSnackBar('Departure and arrival stations cannot be the same');
      return;
    }
    if (!stations.contains(fromStation) || !stations.contains(toStation)) {
      _showErrorSnackBar('Please select valid stations from the list');
      return;
    }

    setState(() {
      isLoading = true;
      isSearched = true;
    });

    try {
      final dayOfWeek = DateFormat('EEEE').format(selectedDate!).toLowerCase();
      final query = await FirebaseFirestore.instance
          .collection('trains')
          .where('from', isEqualTo: fromStation)
          .where('to', isEqualTo: toStation)
          .where('days', arrayContains: dayOfWeek)
          .get()
          .timeout(const Duration(seconds: 10));

      setState(() {
        trainList = query.docs.map((doc) => Train.fromJson(doc.data(), doc.id)).toList();
        isLoading = false;
      });

      if (trainList.isEmpty) {
        _showWarningSnackBar(
            'No trains found for this route on ${DateFormat('EEEE').format(selectedDate!)}');
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showErrorSnackBar('Failed to search trains: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showWarningSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.orange),
    );
  }

  Future<void> _printResults() async {
    if (trainList.isEmpty) {
      _showWarningSnackBar('No trains to print or share');
      return;
    }

    final pdf = pw.Document();
    pdf.addPage(_buildPdfPage());

    final pdfBytes = await pdf.save();

    // Share the PDF
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'Train_Schedule_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }

  pw.Page _buildPdfPage() {
    return pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Center(
            child: pw.Text(
              'Train Schedule',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'From: $fromStation\n'
            'To: $toStation\n'
            'Day: ${DateFormat('EEEE, MMMM d, yyyy').format(selectedDate!)}',
            style: const pw.TextStyle(fontSize: 14),
          ),
          pw.SizedBox(height: 20),
          pw.Container(
            color: PdfColors.grey300,
            child: pw.Row(
              children: [
                pw.Expanded(child: pw.Text('Train No.', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Expanded(child: pw.Text('Name', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Expanded(child: pw.Text('Type', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Expanded(child: pw.Text('Departure', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Expanded(child: pw.Text('Arrival', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Expanded(child: pw.Text('Duration', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              ],
            ),
          ),
          ...trainList.map((train) => pw.Container(
                padding: const pw.EdgeInsets.symmetric(vertical: 8),
                decoration: pw.BoxDecoration(border: pw.Border(bottom: const pw.BorderSide(color: PdfColors.grey300))),
                child: pw.Row(
                  children: [
                    pw.Expanded(child: pw.Text(train.trainNo)),
                    pw.Expanded(child: pw.Text(train.trainName)),
                    pw.Expanded(child: pw.Text(train.trainType)),
                    pw.Expanded(child: pw.Text(train.departure)),
                    pw.Expanded(child: pw.Text(train.arrival)),
                    pw.Expanded(child: pw.Text(train.duration)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void _toggleSaveTrain(Train train) {
    setState(() {
      if (savedTrains.any((t) => t.id == train.id)) {
        savedTrains.removeWhere((t) => t.id == train.id);
        _showWarningSnackBar('${train.trainNo} removed from saved');
      } else {
        savedTrains.add(train);
        _showWarningSnackBar('${train.trainNo} saved');
      }
    });
  }

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

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
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
          labelColor: kPrimaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: kPrimaryColor,
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
            backgroundColor: kPrimaryLight,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: kTextColor),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Text(
            'Train Finder',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kTextColor,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none, color: kPrimaryColor.shade700),
                onPressed: () {
                  _showWarningSnackBar('Notifications not implemented');
                },
              ),
              IconButton(
                icon: Icon(Icons.person_outline, color: kPrimaryColor.shade700),
                onPressed: () {
                  _showWarningSnackBar('Profile not implemented');
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
              child: Center(child: CircularProgressIndicator(color: kPrimaryColor)),
            )
          else if (isSearched)
            _buildTrainList()
          else if (trainList.isNotEmpty)
            _buildPopularRoutes(),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor),
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
                        Text('No saved trains yet', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                        const SizedBox(height: 8),
                        Text(
                          'Save trains from the search tab to view them here',
                          style: TextStyle(fontSize: 14, color: Colors.grey[500]),
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kTextColor),
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
                  color: kPrimaryLight,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.swap_vert, color: kTextColor),
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kTextColor),
              ),
              const SizedBox(height: 8),
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kTextColor),
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
                    Icon(Icons.calendar_today, color: kPrimaryColor.shade700),
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
                              color: selectedDate != null ? kTextColor : Colors.grey[600],
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
            onPressed: _searchTrainsFromFirestore,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: kPrimaryColor.shade300,
              foregroundColor: kTextColor,
            ),
            child: const Text(
              'Search Trains',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        final input = textEditingValue.text.toLowerCase();
        return stations.where((station) => station.toLowerCase().contains(input));
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
            prefixIcon: Icon(Icons.train, color: kPrimaryColor.shade700),
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
                itemBuilder: (context, index) => ListTile(
                  title: Text(options.elementAt(index)),
                  onTap: () => onSelected(options.elementAt(index)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrainList() {
    List<Train> filteredTrains = [...trainList];

    if (selectedTrainTypeFilter != null && selectedTrainTypeFilter != 'All') {
      filteredTrains = filteredTrains.where((train) => train.trainType == selectedTrainTypeFilter).toList();
    }

    if (selectedTimeFilter != null) {
      filteredTrains = filteredTrains.where((train) {
        try {
          final hour = int.parse(train.departure.split(':')[0]);
          if (selectedTimeFilter == 'Morning') return hour < 12;
          if (selectedTimeFilter == 'Afternoon') return hour >= 12 && hour < 17;
          if (selectedTimeFilter == 'Evening') return hour >= 17;
          return true;
        } catch (e) {
          return false;
        }
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kTextColor),
              ),
              Row(
                children: [
                 
                  InkWell(
                    onTap: _printResults,
                    child: Row(
                      children: [
                        Icon(Icons.share, size: 18, color: kTextColor),
                        const SizedBox(width: 4),
                        Text(
                          'Share',
                          style: const TextStyle(
                            color: kTextColor,
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
                        Icon(Icons.filter_list, size: 18, color: kTextColor),
                        const SizedBox(width: 4),
                        Text(
                          'Filter',
                          style: const TextStyle(
                            color: kTextColor,
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
                color: kPrimaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today, size: 16, color: kPrimaryColor.shade700),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('EEEE, MMMM d, yyyy').format(selectedDate!),
                    style: TextStyle(color: kPrimaryColor.shade900),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          if (filteredTrains.isEmpty)
            const Center(
                child: Text('No trains match your search criteria', style: TextStyle(color: kTextColor)))
          else
            Column(
              children: filteredTrains.map((train) => _buildTrainCard(train)).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildPopularRoutes() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.star_rounded, color: kPrimaryColor.shade700, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Popular Routes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: trainList.length,
            itemBuilder: (context, index) => _buildTrainCard(
              trainList[index],
              isPopular: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBottomSheet() {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          height: 360,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter Trains',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: ['All', 'Express', 'Local'].map((label) {
                    final isSelected = selectedTrainTypeFilter == label;
                    return ChoiceChip(
                      label: Text(label),
                      selected: isSelected,
                      selectedColor: kPrimaryColor.shade700,
                      labelStyle: TextStyle(
                        color: isSelected ? kTextColor : Colors.black,
                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                      ),
                      onSelected: (selected) {
                        setModalState(() {
                          selectedTrainTypeFilter = selected ? label : null;
                        });
                        setState(() {
                          selectedTrainTypeFilter = selected ? label : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: ['Morning', 'Afternoon', 'Evening'].map((label) {
                    final isSelected = selectedTimeFilter == label;
                    return ChoiceChip(
                      label: Text(label),
                      selected: isSelected,
                      selectedColor: kPrimaryColor.shade700,
                      labelStyle: TextStyle(
                        color: isSelected ? kTextColor : Colors.black,
                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                      ),
                      onSelected: (selected) {
                        setModalState(() {
                          selectedTimeFilter = selected ? label : null;
                        });
                        setState(() {
                          selectedTimeFilter = selected ? label : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setModalState(() {
                          selectedTrainTypeFilter = null;
                          selectedTimeFilter = null;
                        });
                        setState(() {
                          selectedTrainTypeFilter = null;
                          selectedTimeFilter = null;
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Clear Filters', style: TextStyle(color: Colors.red)),
                    ),
                    Container(
                      width: 120,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: Navigator.of(context).canPop()
                            ? () => Navigator.pop(context)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor.shade300,
                          foregroundColor: kTextColor,
                        ),
                        child: const Text('Apply Filters'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
      selectedColor: kPrimaryColor.shade700,
      labelStyle: TextStyle(
        color: isSelected ? kTextColor : Colors.black,
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
      ),
      onSelected: (selected) {
        onSelected(selected ? label : null);
      },
    );
  }

  Widget _buildTrainCard(Train train, {bool isPopular = false}) {
    final int availableSeats = int.tryParse(train.available) ?? 0;
    final bool isLowAvailability = availableSeats < 15;
    final statusStyle = getStatusStyle(train.status);
    final bool isSaved = savedTrains.any((t) => t.id == train.id);

    String formattedDeparture = train.departure;
    String formattedArrival = train.arrival;
    try {
      final departureTime = DateFormat.Hm().parse(train.departure);
      final arrivalTime = DateFormat.Hm().parse(train.arrival);
      formattedDeparture = DateFormat.jm().format(departureTime);
      formattedArrival = DateFormat.jm().format(arrivalTime);
    } catch (_) {}

    return GestureDetector(
      onTap: isPopular
          ? () {
              setState(() {
                _fromController.text = train.from;
                _toController.text = train.to;
                fromStation = train.from;
                toStation = train.to;
                selectedDate = DateTime.now();
              });
              _searchTrainsFromFirestore();
            }
          : null,
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
                gradient: const LinearGradient(colors: [kPrimaryLight, kPrimaryColor]),
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
                            color: kPrimaryColor.shade800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            train.trainName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: kTextColor,
                            ),
                          ),
                          Text(
                            train.trainType,
                            style: TextStyle(
                              color: kPrimaryColor.shade700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: kPrimaryColor.shade700,
                          size: 20,
                        ),
                        onPressed: () => _toggleSaveTrain(train),
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
                  Row(
                    children: [
                      Icon(Icons.access_time, color: kPrimaryColor.shade600),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedDeparture,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kTextColor),
                          ),
                          const Text(
                            'Departure',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(train.duration, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
                      Icon(Icons.arrow_forward, color: kPrimaryColor.shade600, size: 16),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formattedArrival,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kTextColor),
                          ),
                          const Text(
                            'Arrival',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.location_on, color: kPrimaryColor.shade600, size: 20),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        isLowAvailability ? Icons.warning_amber : Icons.event_seat,
                        color: isLowAvailability ? Colors.red.shade600 : Colors.green.shade600,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isLowAvailability ? 'Low Availability' : '$availableSeats Seats',
                        style: TextStyle(
                          color: isLowAvailability ? Colors.red.shade600 : Colors.green.shade600,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 6,
                    children: train.classes.isEmpty
                        ? [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'No Classes',
                                style: TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                            )
                          ]
                        : train.classes.map((classType) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: kPrimaryLight,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                classType,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: kPrimaryColor.shade900,
                                ),
                              ),
                            );
                          }).toList(),
                  ),
                ],
              ),
            ),
            if (!isPopular)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ElevatedButton(
                  onPressed: () {
                    _showWarningSnackBar('Booking for ${train.trainNo} not implemented');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Book Now'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}