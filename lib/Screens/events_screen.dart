import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List to hold events fetched from Firestore
  List<Map<String, dynamic>> approvedEvents = [];

  // Loading indicator
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  // Fetch events from Firestore
  Future<void> loadEvents() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Event')
          .where('status', isEqualTo: 'Approved')
          //.orderBy('Date', descending: true)
          .get();

      setState(() {
        approvedEvents = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.00),
        child: ListView.builder(
          itemCount: approvedEvents.length,
          itemBuilder: (context, index) {
            final event = approvedEvents[index];
            return EventCard(event: event);
          },
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Club Name
            Row(
              children: [
                const Icon(Icons.group, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  event['clubName'] ?? 'Unknown Club',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Event Details
            buildEventDetail(Icons.calendar_today, 'Date', event['date']),
            buildEventDetail(Icons.access_time, 'Time', event['timeOfEvent']),
            buildEventDetail(
                Icons.location_on, 'Destination', event['destination']),
            buildEventDetail(
                Icons.place, 'Assembly Location', event['assemblyLocation']),
            buildEventDetail(Icons.event_note, 'Reason', event['reasonOfEvent']),
          ],
        ),
      ),
    );
  }

  Widget buildEventDetail(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: ${value ?? 'N/A'}',
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
