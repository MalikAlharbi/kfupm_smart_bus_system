import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Simple Connection',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MessageScreen(), // Call MessageScreen as home
    );
  }
}

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore Simple Connection')),
      body: MessageWidget(),
    );
  }
}

class MessageWidget extends StatefulWidget {
  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  final TextEditingController _controller = TextEditingController();

  // Function to write a custom message to Firestore
  void writeMessage() {
    final messages = FirebaseFirestore.instance.collection('messages');
    messages.add({'message': _controller.text}).then((value) {
      print("Message Added: ${_controller.text}");
      _controller.clear(); // Clear the input field after adding
    }).catchError((error) => print("Failed to add message: $error"));
  }

  // Function to read the last message from Firestore
  Stream<QuerySnapshot> readMessages() {
    return FirebaseFirestore.instance.collection('messages').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter a message',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: writeMessage,
          child: Text("Send Message"),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: readMessages(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              // Display messages from Firestore
              final messages = snapshot.data!.docs.map((doc) {
                return doc['message'] as String;
              }).toList();

              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index]),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

void main() async {
  // Ensure Firebase is initialized before the app starts
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp()); // Run the app with MyApp as the root widget
}
