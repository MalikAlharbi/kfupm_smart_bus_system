import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  // Dummy data for approved events
  final List<Map<String, String>> approvedEvents = [
    {
      'status': 'Approved',
      'date': '2024-11-30',
      'time': '3:00 PM',
      'destination': 'Photography Club Event',
      'assemblyLocation': 'Main Gate',
      'reason': 'Annual Club Meeting',
      'clubName': 'Photography Club',
    },
    {
      'status': 'Approved',
      'date': '2024-12-05',
      'time': '10:00 AM',
      'destination': 'Robotics Competition',
      'assemblyLocation': 'Engineering Building',
      'reason': 'National Robotics Competition',
      'clubName': 'Robotics Club',
    },
    {
      'status': 'Approved',
      'date': '2024-12-15',
      'time': '1:30 PM',
      'destination': 'Art Exhibition',
      'assemblyLocation': 'Auditorium',
      'reason': 'Displaying Student Artworks',
      'clubName': 'Art Club',
    },
    {
      'status': 'Approved',
      'date': '2025-12-16',
      'time': '1:20 PM',
      'destination': 'Art Exhibition',
      'assemblyLocation': 'Auditorium',
      'reason': 'Displaying Artworks',
      'clubName': 'Computer Club',
    },
  ];

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
  final Map<String, String> event;

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
            buildEventDetail(Icons.access_time, 'Time', event['time']),
            buildEventDetail(
                Icons.location_on, 'Destination', event['destination']),
            buildEventDetail(
                Icons.place, 'Assembly Location', event['assemblyLocation']),
            buildEventDetail(Icons.event_note, 'Reason', event['reason']),
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
