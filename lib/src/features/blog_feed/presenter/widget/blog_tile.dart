import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ionicons/ionicons.dart';

class BlogTile extends StatefulWidget {
  final String title;
  final String description;
  final String date;
  final String imageUrl;

  const BlogTile({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });

  @override
  State<BlogTile> createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  late FlutterTts flutterTts;
  final ScrollController scrollController = ScrollController();

  final ValueNotifier<double> scrollPositionNotifier =
      ValueNotifier<double>(0.0);

  int? _currentWordStart, _currentWordEnd;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    initTTS();

    scrollController.addListener(() {
      scrollPositionNotifier.value = scrollController.offset /
          (scrollController.position.maxScrollExtent == 0
              ? 1
              : scrollController.position.maxScrollExtent);
    });
  }

  void initTTS() {
    try {
      flutterTts
          .setVoice({"name": "en-us-x-sfg#male_1-local", "locale": "en-US"});
    } catch (e) {
      print(e);
    }

    flutterTts.setStartHandler(() {
      flutterTts.setVolume(1.0);
      flutterTts.setSpeechRate(0.9);
      flutterTts.setPitch(.8);
    });

    flutterTts.setProgressHandler((text, start, end, word) {
      setState(() {
        // _currentWordStart = start;
        // _currentWordEnd = end;
        if (_currentWordStart != start || _currentWordEnd != end) {
          _currentWordStart = start;
          _currentWordEnd = end;
          scrollController.jumpTo(
              scrollController.position.maxScrollExtent * (end / text.length));
        }
      });
    });

    flutterTts.setCompletionHandler(() {
      print("Complete");
    });

    flutterTts.setErrorHandler((msg) {
      print("error: $msg");
    });

    flutterTts.setPauseHandler(() {
      print("Paused");
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    scrollController.dispose();
    scrollPositionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    return Column(
      children: [
        InkWell(
          onTap: () {
            buildBlogDetailsSheet(context, isPlaying);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 2,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  height: 1.2,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.7),
                                ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.description,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.5),
                                ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 16,
                          ),
                          Text(
                            " ● ${widget.date}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.primary.withOpacity(.1),
          thickness: 1,
          indent: 8,
          endIndent: 8,
        ),
      ],
    );
  }

  Future<dynamic> buildBlogDetailsSheet(BuildContext context, bool isPlaying) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: ValueListenableBuilder<double>(
            valueListenable: scrollPositionNotifier,
            builder: (context, scrollPosition, child) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        flutterTts.stop();
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                                                  .secondary,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(.1),
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

                              // Text(
                              //   widget.description,
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .displaySmall
                              //       ?.copyWith(
                              //         height: 1.5,
                              //         color: Theme.of(context)
                              //             .colorScheme
                              //             .primary
                              //             .withOpacity(.7),
                              //       ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Divider(
                      color:
                          Theme.of(context).colorScheme.primary.withOpacity(.1),
                      thickness: 1,
                      indent: 8,
                      endIndent: 8,
                    ),
                    Row(
                      children: [
                        FloatingActionButton.small(
                          tooltip: isPlaying ? 'Pause' : 'Play',
                          onPressed: () {
                            // setState(() {
                            // isPlaying = !isPlaying;
                            // });
                            // if (isPlaying) {
                            // flutterTts.pause();
                            // } else {
                            flutterTts.speak(widget.description);
                            // }
                          },
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: isPlaying
                              ? const Icon(Ionicons.pause)
                              : const Icon(Ionicons.play),
                        ),
                        Expanded(
                          child: Slider(
                            inactiveColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.2),
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            value: scrollPosition.clamp(0.0, 1.0),
                            onChanged: (double value) {
                              scrollPositionNotifier.value = value;
                              scrollController.jumpTo(
                                value *
                                    scrollController.position.maxScrollExtent,
                              );
                            },
                          ),
                        ),
                        FloatingActionButton.small(
                          tooltip: 'Next',
                          onPressed: () {},
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
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
      },
    );
  }
}
