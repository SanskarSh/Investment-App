import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ionicons/ionicons.dart';

class BlogDetailsSheet extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;

  const BlogDetailsSheet({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  State<BlogDetailsSheet> createState() => _BlogDetailsSheetState();
}

class _BlogDetailsSheetState extends State<BlogDetailsSheet> {
  // Notifies the state of the TTS (Text-to-Speech) playback.
  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);

  // Variables to track the currently highlighted word in the text.
  int? _currentWordStart, _currentWordEnd;

  // FlutterTts instance for handling text-to-speech operations.
  late FlutterTts flutterTts;

  // Controller for the scrollable view.
  final ScrollController scrollController = ScrollController();

  // Notifies the scroll position of the text content.
  final ValueNotifier<double> scrollPositionNotifier =
      ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    initTTS(); // Initialize text-to-speech functionality.

    // Update scroll position when the user scrolls.
    scrollController.addListener(() {
      // Calculate and update scroll position.
      scrollPositionNotifier.value = scrollController.offset /
          (scrollController.position.maxScrollExtent == 0
              ? 1
              : scrollController.position.maxScrollExtent);
    });
  }

  // Variable to store the previous scroll position for optimization.
  double _previousScrollPosition = 0.0;

  // Update the scroll position within the debounced function
  void updateScrollPositionDebounced(double newScrollPosition) {
    // Call the debouncer function here
    if (newScrollPosition - _previousScrollPosition > 0.01) {
      _previousScrollPosition = newScrollPosition;
      scrollController.jumpTo(
          newScrollPosition * scrollController.position.maxScrollExtent);
    }
    scrollPositionNotifier.value = newScrollPosition;
  }

  // Initializes the FlutterTts instance with settings and handlers.
  void initTTS() {
    try {
      flutterTts
          .setVoice({"name": "en-us-x-sfg#male_1-local", "locale": "en-US"});
    } catch (e) {
      print(e);
    }

    flutterTts.setStartHandler(() {
      // When TTS playback starts, set isPlayingNotifier to true.
      isPlayingNotifier.value = true;
      flutterTts.setVolume(.9);
      flutterTts.setSpeechRate(0.3);
      flutterTts.setPitch(.5);
    });

    flutterTts.setProgressHandler((text, start, end, word) {
      setState(() {
        // Update the highlighted word indices when TTS progresses.
        if (_currentWordStart != start || _currentWordEnd != end) {
          _currentWordStart = start;
          _currentWordEnd = end;
          // Update scroll position based on the current word.
          updateScrollPositionDebounced(start / text.length);
        }
      });
    });

    flutterTts.setCompletionHandler(() {
      // When TTS playback completes, reset highlighted word and isPlayingNotifier.
      setState(() {
        _currentWordStart = null;
        _currentWordEnd = null;
      });
      isPlayingNotifier.value = false;
      print("Complete");
    });

    flutterTts.setPauseHandler(() {
      // When TTS playback pauses, set isPlayingNotifier to false.
      isPlayingNotifier.value = false;
    });

    flutterTts.setErrorHandler((msg) {
      // Log errors encountered during TTS operations.
      print("error: $msg");
    });
  }

  @override
  void dispose() {
    // Cleanup resources when the widget is disposed.
    flutterTts.stop();
    scrollController.dispose();
    scrollPositionNotifier.dispose();
    isPlayingNotifier.dispose();
    _currentWordStart = null;
    _currentWordEnd = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<double>(
        valueListenable: scrollPositionNotifier,
        builder: (context, scrollPosition, child) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    // Close the blog details sheet when tapped.
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Ionicons.close,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 10,
                  shadowColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            widget.title,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    height: 1.5,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.7),
                                  ),
                              children: [
                                TextSpan(
                                  text: widget.description
                                      .substring(0, _currentWordStart),
                                ),
                                if (_currentWordStart != null &&
                                    _currentWordEnd != null)
                                  TextSpan(
                                    text: widget.description.substring(
                                      _currentWordStart!,
                                      _currentWordEnd,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(
                                          height: 1.5,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(.5),
                                        ),
                                  ),
                                if (_currentWordEnd != null)
                                  TextSpan(
                                    text: widget.description
                                        .substring(_currentWordEnd!),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Divider(
                  color: Theme.of(context).colorScheme.primary.withOpacity(.1),
                  thickness: 1,
                  indent: 8,
                  endIndent: 8,
                ),
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: isPlayingNotifier,
                      builder: (context, scrollPosition, child) {
                        return FloatingActionButton.small(
                          tooltip: isPlayingNotifier.value ? 'Pause' : 'Play',
                          onPressed: () {
                            // Toggle TTS playback when play/pause button is pressed.
                            if (isPlayingNotifier.value) {
                              flutterTts.pause();
                            } else {
                              flutterTts.speak(widget.description);
                            }
                            // Toggle isPlayingNotifier value.
                            isPlayingNotifier.value = !isPlayingNotifier.value;
                          },
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: isPlayingNotifier.value
                              ? const Icon(Ionicons.pause)
                              : const Icon(Ionicons.play),
                        );
                      },
                    ),
                    Expanded(
                      child: Slider(
                        // Customize slider appearance.
                        inactiveColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.2),
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: scrollPosition.clamp(0.0, 1.0),
                        onChanged: (double value) {
                          // Update scroll position based on slider value.
                          scrollPositionNotifier.value = value;
                          scrollController.jumpTo(
                            value * scrollController.position.maxScrollExtent,
                          );
                        },
                      ),
                    ),
                    FloatingActionButton.small(
                      tooltip: 'Next',
                      onPressed: () {},
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: const Icon(
                        Ionicons.arrow_forward,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
