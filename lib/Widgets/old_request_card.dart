import 'package:flutter/material.dart';

class OldRequestCard extends StatelessWidget {
  final int requestNumber;
  final String status;

  const OldRequestCard({
    super.key,
    required this.requestNumber,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Request Number
          Text(
            "Request Number: #$requestNumber",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),

          // Status
          Row(
            children: [
              const Text(
                "Status: ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),

          
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withOpacity(
                      0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _getStatusColor(
                          status)),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 16,
                    color: _getStatusColor(status), 
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // function to determine color based on the status
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}