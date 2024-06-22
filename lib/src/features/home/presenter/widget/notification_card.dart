
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({super.key});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  final List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  final List<String> _names = [
    "Get Health Insurance",
    "Get Life Insurance for 25 X Salary",
    "Get Term Insurance",
    "Collect Emergency Fund (6-12 X Monthly Expenses)",
    "Start Investing",
  ];
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {},
          nopeAction: () {},
          superlikeAction: () {},
          onSlideUpdate: (SlideRegion? region) async {}));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: SwipeCards(
        matchEngine: _matchEngine,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: _swipeItems[index].content.color,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: double.infinity,
                width: double.infinity,
                child: Text(
                  textAlign: TextAlign.center,
                  _swipeItems[index].content.text,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          );
        },
        onStackFinished: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("No pending alerts.."),
            duration: const Duration(milliseconds: 500),
          ));
        },
        itemChanged: (SwipeItem item, int index) {
          print("item: ${item.content.text}, index: $index");
        },
        upSwipeAllowed: true,
        fillSpace: true,
      ),
    );
  }
}

class Content {
  final String text;
  final Color color;

  Content({required this.text, required this.color});
}
