
import 'package:flutter/material.dart';

class VideoTab extends StatelessWidget {
  const VideoTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Theme.of(context).colorScheme.secondary,
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Center(
                  child: Text(
                    "Video goes here",
                    style:
                        Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

