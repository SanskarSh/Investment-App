import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  reverse: true,
                  children: const [
                    SizedBox(height: 40.0),
                    // MessageBubble(
                    //   sender: 'Sender 1',
                    //   message: 'Hello!',
                    //   isMe: false,
                    // ),
                    // MessageBubble(
                    //   sender: 'Sender 2',
                    //   message: 'Hi there!',
                    //   isMe: true,
                    // ),
                    // MessageBubble(
                    //   sender: 'Sender 1',
                    //   message: 'How are you?',
                    //   isMe: false,
                    // ),
                    MessageBubble(
                      sender: 'Bot 🤖',
                      message: 'How can I help you!',
                      isMe: false,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(Ionicons.send),
                          onPressed: () {},
                        ),
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.sender,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe
                  ? const Radius.circular(30.0)
                  : const Radius.circular(0.0),
              topRight: const Radius.circular(30.0),
              bottomLeft: const Radius.circular(30.0),
              bottomRight: isMe
                  ? const Radius.circular(0.0)
                  : const Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isMe
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.onPrimary,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
