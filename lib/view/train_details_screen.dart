import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teasy/components/slct-yr-train-pg-cmpnts/train_routes_selector.dart';
import 'package:teasy/components/trn-dtl-pg-cmpnts/booking_form.dart';
import 'package:teasy/components/trn-dtl-pg-cmpnts/header_dtl.dart';
import 'package:teasy/components/trn-dtl-pg-cmpnts/stations_details.dart';
import 'package:teasy/components/trn-dtl-pg-cmpnts/train_img.dart';
import 'package:teasy/models/train_model.dart';
import 'package:teasy/repositories/train_repository.dart';

class TrainDetailsScreen extends StatefulWidget {
  final String trainId;

  const TrainDetailsScreen({super.key, required this.trainId});

  @override
  State<TrainDetailsScreen> createState() => _TrainDetailsScreenState();
}

class _TrainDetailsScreenState extends State<TrainDetailsScreen> {
  late Future<Train?> _trainFuture; // Changed to nullable Train type
  final TrainRepository _trainRepository = TrainRepository();
  bool _isRetrying = false;
  int _retryAttempt = 0;
  final int _maxRetries = 3;

  @override
  void initState() {
    super.initState();
    debugPrint('Train ID received: ${widget.trainId}');
    _loadTrainData();
  }

  void _loadTrainData() {
    setState(() {
      _trainFuture = _fetchTrainWithRetry();
    });
  }

  Future<Train?> _fetchTrainWithRetry() async {
    setState(() {
      _isRetrying = false;
      _retryAttempt = 0;
    });

    for (int attempt = 0; attempt < _maxRetries; attempt++) {
      try {
        if (attempt > 0) {
          // Show retry indicator for attempts after the first one
          setState(() {
            _isRetrying = true;
            _retryAttempt = attempt;
          });

          // Exponential backoff - wait longer between each retry
          final backoffDuration =
              Duration(seconds: 1 << (attempt - 1)); // 1s, 2s, 4s
          await Future.delayed(backoffDuration);
        }

        // Try to fetch the train data
        return await _trainRepository.getTrainById(widget.trainId);
      } catch (e) {
        debugPrint('Attempt ${attempt + 1} failed: $e');

        // On last attempt, rethrow to show error UI
        if (attempt == _maxRetries - 1) {
          setState(() => _isRetrying = false);
          rethrow;
        }
        // Otherwise continue to next retry attempt
      }
    }

    // This should never be reached due to the rethrow above, but Dart requires a return
    throw Exception('Failed to load train data after $_maxRetries attempts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          width: 36,
          height: 36,
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        title: const Text(
          "Train Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: FutureBuilder<Train?>(
        future: _trainFuture,
        builder: (context, snapshot) {
          // Show retry status if actively retrying
          if (_isRetrying) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text(
                    'Connection issue detected\nRetrying... (Attempt ${_retryAttempt + 1}/$_maxRetries)',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }

          // Normal loading state
          if (snapshot.connectionState == ConnectionState.waiting &&
              !_isRetrying) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          else if (snapshot.hasError) {
            final errorMessage = _getErrorMessage(snapshot.error);

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.signal_wifi_off,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _loadTrainData,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // No data state
          else if (!snapshot.hasData) {
            return const Center(child: Text('No train data found.'));
          }

          // Success state - display train data
          final train = snapshot.data!;
          return SingleChildScrollView(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 1,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    HeaderDtl(train: train),
                    const SizedBox(height: 10),
                    const TrainImg(),
                    const SizedBox(height: 10),
                    StationsDetails(train: train),
                    const SizedBox(height: 10),
                    const TrainRoutesSelector(),
                    const SizedBox(height: 10),
                    const BookingForm(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getErrorMessage(dynamic error) {
    final errorStr = error.toString().toLowerCase();

    if (errorStr.contains('unavailable') ||
        errorStr.contains('unable to resolve host')) {
      return 'Network error: Unable to connect to server.\nPlease check your internet connection and try again.';
    } else if (errorStr.contains('not found')) {
      return 'Train information not found.';
    } else if (errorStr.contains('permission') || errorStr.contains('denied')) {
      return 'You don\'t have permission to access this information.';
    } else {
      return 'An error occurred while loading train data.\nPlease try again later.';
    }
  }
}
