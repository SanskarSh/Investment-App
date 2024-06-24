import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:investment_app/src/features/explore_feed/model/module_model.dart';
import 'package:investment_app/src/features/explore_feed/presenter/widget/quiz.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class ModuleDetailsSheet extends StatefulWidget {
  final ModuleModel module;

  const ModuleDetailsSheet({
    super.key,
    required this.module,
  });

  @override
  State<ModuleDetailsSheet> createState() => _ModuleDetailsSheetState();
}

class _ModuleDetailsSheetState extends State<ModuleDetailsSheet> {
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
    return ValueListenableBuilder<double>(
      valueListenable: scrollPositionNotifier,
      builder: (context, scrollPosition, child) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  height: 250,
                  width: double.infinity,
                  child: SizedBox(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: widget.module.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.1),
                        highlightColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.2),
                        child: Container(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.1),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            widget.module.title,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 40,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const SizedBox(height: 32),
                          Divider(
                            color: Theme.of(context).colorScheme.primary,
                            thickness: 1,
                            indent: 8,
                            endIndent: 8,
                          ),
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
                                  text: widget.module.content
                                      .substring(0, _currentWordStart),
                                ),
                                if (_currentWordStart != null &&
                                    _currentWordEnd != null)
                                  TextSpan(
                                    text: widget.module.content.substring(
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
                                    text: widget.module.content
                                        .substring(_currentWordEnd!),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.module.quiz.length,
                            itemBuilder: (context, index) => Quiz(
                              onOptionSelected: (p0) => {},
                              quizModel: widget.module.quiz[index],
                            ),
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 8),
              ],
            ),
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Ionicons.close,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
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
                              flutterTts.speak(widget.module.content);
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
              ),
            )
          ],
        );
      },
    );
  }
}
