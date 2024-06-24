import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:investment_app/src/core/constant/string.dart';
import 'package:ionicons/ionicons.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static String geminiApiKey = Config.geminiAPI;
  final List<Message> _messages = [
    Message(
      sender: 'Bot 🤖',
      message: 'How can I help you!',
      isMe: false,
      date: DateTime.now(),
    ),
  ];
  final TextEditingController _controller = TextEditingController();
  final model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: geminiApiKey);
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {}
    });
  }

  @override
  dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      final message = _controller.text;
      setState(() {
        _messages.add(
          Message(
            sender: 'You',
            message: message,
            isMe: true,
            date: DateTime.now(),
          ),
        );
        _controller.clear();
        _isLoading = true;
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });

      final content = [
        Content.text(
            "You are a financial expert at WiseVault, a renowned financial services company known for its expertise in investment strategies, wealth management, and financial planning. Your role is to provide detailed, accurate, and insightful answers to all finance-related inquiries. You have extensive knowledge in various financial domains including stock markets, mutual funds, retirement planning, tax strategies, real estate investments, and personal finance management. Give response to the following question in less than 100 words and don't use any markdown elements $message")
      ];
      final response = await model.generateContent(content);
      setState(() {
        _messages.add(
          Message(
            sender: 'Bot 🤖',
            message: response.text?.replaceAll('*', '') ?? "",
            isMe: false,
            date: DateTime.now(),
          ),
        );
        _isLoading = false;
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

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
                  const SizedBox(width: 10.0),
                  Text(
                    '🤖 Chat',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              Expanded(
                // Step 1: Attach ScrollController to ListView.builder
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _messages.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_isLoading && index == _messages.length) {
                      return MessageBubble(
                        sender: 'Bot 🤖',
                        message: '...',
                        isMe: false,
                        date: DateFormat('HH:mm').format(DateTime.now()),
                      );
                    }
                    final message = _messages[index];
                    return MessageBubble(
                      sender: message.sender,
                      message: message.message,
                      isMe: message.isMe,
                      date: DateFormat('HH:mm').format(message.date),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: _controller,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(Ionicons.send),
                          onPressed: _sendMessage,
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
  final String date;

  const MessageBubble({
    super.key,
    required this.sender,
    required this.message,
    required this.isMe,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            Row(
              children: [
                Text(
                  sender,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
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
          if (isMe) ...[
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  sender,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class Message {
  final String sender;
  final String message;
  final bool isMe;
  final DateTime date;

  const Message({
    required this.sender,
    required this.message,
    required this.isMe,
    required this.date,
  });
}
