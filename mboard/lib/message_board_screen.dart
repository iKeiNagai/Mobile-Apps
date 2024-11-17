import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageBoardScreen extends StatelessWidget {
  final String boardName;

  MessageBoardScreen({required this.boardName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(boardName),
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageList(boardName: boardName),
          ),
          MessageInput(boardName: boardName),
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  final String boardName;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MessageList({required this.boardName});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('message_boards')
          .doc(boardName)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        var messages = snapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            var message = messages[index];
            return ListTile(
              title: Text(message['message']),
              subtitle: Text(
                'Posted by: ${message['firstName']} at ${message['timestamp'].toDate()}',
              ),
            );
          },
        );
      },
    );
  }
}

class MessageInput extends StatefulWidget {
  final String boardName;

  MessageInput({required this.boardName});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
  if (_messageController.text.trim().isEmpty) return;

  // Get the current user
  User? user = FirebaseAuth.instance.currentUser;
  String? uid = user?.uid;

  String firstName = 'Anonymous'; // Default to Anonymous
  if (uid != null) {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        firstName = userDoc['firstName'] ?? 'Anonymous';
      }
    } catch (e) {
      Text('Error fetching user data: $e');
    }
  }

  // Add the message to Firestore
  await FirebaseFirestore.instance
      .collection('message_boards')
      .doc(widget.boardName)
      .collection('messages')
      .add({
    'message': _messageController.text.trim(),
    'firstName': firstName,  // Store the first name here
    'timestamp': Timestamp.now(),
  });

  _messageController.clear();
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Enter your message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
